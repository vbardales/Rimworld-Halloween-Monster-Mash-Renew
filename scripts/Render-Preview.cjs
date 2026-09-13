// Render the editable HTML overlay and verify the actual PNG, not just CSS colors.
// Requires playwright and sharp (NODE_PATH may point to the bundled dependencies).
// Set CHROME_PATH when a Playwright-managed Chromium is not installed.
const fs = require('node:fs');
const path = require('node:path');
const assert = require('node:assert/strict');
const { chromium } = require('playwright');
const sharp = require('sharp');
const root = path.resolve(__dirname, '..');
const art = path.join(root, 'Art');
const qa = path.join(art, 'qa');
const luminance = rgb => rgb.map(c => {
  const s = c / 255;
  return s <= .04045 ? s / 12.92 : ((s + .055) / 1.055) ** 2.4;
}).reduce((sum, c, i) => sum + c * [.2126, .7152, .0722][i], 0);
const ratio = (a, b) => (Math.max(a, b) + .05) / (Math.min(a, b) + .05);

(async () => {
  fs.mkdirSync(qa, { recursive: true });
  const browser = await chromium.launch({
    headless: true,
    ...(process.env.CHROME_PATH ? { executablePath: process.env.CHROME_PATH } : {})
  });
  try {
    const page = await browser.newPage({ viewport: { width: 896, height: 504 }, deviceScaleFactor: 1 });
    // Serve only these local assets. No network, local web server or file-fetch flags needed.
    const assets = {
      '/Preview-text.html': 'text/html',
      '/preview-palette.json': 'application/json',
      '/Preview-source.png': 'image/png'
    };
    await page.route('**/*', async route => {
      const url = new URL(route.request().url());
      if (url.origin !== 'http://preview.local' || !assets[url.pathname]) return route.abort();
      return route.fulfill({ contentType: assets[url.pathname], body: fs.readFileSync(path.join(art, url.pathname.slice(1))) });
    });
    await page.goto('http://preview.local/Preview-text.html');
    const palette = await page.evaluate(() => window.previewReady);
    const about = fs.readFileSync(path.join(root, 'Mod/About/About.xml'), 'utf8');
    const versions = [...about.match(/<supportedVersions>([\s\S]*?)<\/supportedVersions>/)[1].matchAll(/<li>([\d.]+)<\/li>/g)]
      .map(m => m[1]).sort((a, b) => a.localeCompare(b, undefined, { numeric: true }));
    assert.equal(await page.locator('.version').innerText(), versions.at(-1));
    assert.equal(await page.locator('.tag').innerText(), '(unofficial)');
    const cdp = await page.context().newCDPSession(page);
    await cdp.send('DOM.enable');
    await cdp.send('CSS.enable');
    const { root: dom } = await cdp.send('DOM.getDocument');
    const fonts = {};
    for (const selector of ['h1', '.suffix', '.tag', '.summary', '.version']) {
      const { nodeId } = await cdp.send('DOM.querySelector', { nodeId: dom.nodeId, selector });
      fonts[selector] = (await cdp.send('CSS.getPlatformFontsForNode', { nodeId })).fonts;
      assert(fonts[selector].length && fonts[selector].every(f => f.familyName.startsWith('Segoe UI')), 'Unexpected font: ' + selector + JSON.stringify(fonts[selector]));
    }
    const boxes = await page.evaluate(() => {
      const result = [];
      for (const selector of ['.title-line', '.suffix', '.tag', '.summary']) {
        document.querySelectorAll(selector).forEach(element => {
          const range = document.createRange();
          range.selectNodeContents(element);
          for (const r of range.getClientRects()) result.push({
            selector, x: r.x, y: r.y, width: r.width, height: r.height,
            color: getComputedStyle(element).color
          });
        });
      }
      const titleSize = parseFloat(getComputedStyle(document.querySelector('h1')).fontSize);
      const suffixSize = parseFloat(getComputedStyle(document.querySelector('.suffix')).fontSize);
      if (Math.abs(suffixSize / titleSize - .65) > .001) throw new Error('Wrong suffix scale');
      return result;
    });
    assert(boxes.every(b => b.x >= 0 && b.y >= 0 && b.x + b.width <= 792 && b.y + b.height <= 504), 'Text overflow or badge overlap');
    const rendered = await page.screenshot();
    await page.addStyleTag({ content: '.text, .version { visibility: hidden; }' });
    const background = await page.screenshot();
    fs.writeFileSync(path.join(qa, 'Preview-background.png'), background);
    const { data, info } = await sharp(background).removeAlpha().raw().toBuffer({ resolveWithObject: true });
    const contrast = boxes.map(box => {
      const ink = luminance(box.color.match(/[\d.]+/g).slice(0, 3).map(Number));
      let minimum = Infinity;
      for (let y = Math.floor(box.y); y < Math.ceil(box.y + box.height); y++) {
        for (let x = Math.floor(box.x); x < Math.ceil(box.x + box.width); x++) {
          const offset = (y * info.width + x) * info.channels;
          minimum = Math.min(minimum, ratio(ink, luminance([...data.subarray(offset, offset + 3)])));
        }
      }
      return { ...box, minimum: +minimum.toFixed(3) };
    });
    const fromHex = value => luminance(value.slice(1).match(/../g).map(x => parseInt(x, 16)));
    const badgeContrast = ratio(fromHex(palette.badgeInk), fromHex(palette.accent));
    const meta = await sharp(rendered).metadata();
    assert.equal(meta.width, 896);
    assert.equal(meta.height, 504);
    assert(rendered.length < 1_000_000, 'Preview exceeds size limit');
    const report = { date: new Date().toISOString(), fonts, palette, bytes: rendered.length, contrast, badgeContrast, passed: contrast.every(b => b.minimum >= 4.5) && badgeContrast >= 4.5 };
    fs.writeFileSync(path.join(qa, 'preview-checks.json'), JSON.stringify(report, null, 2) + '\n');
    fs.writeFileSync(path.join(qa, 'Preview-candidate.png'), rendered);
    await sharp(rendered).resize({ width: 268 }).png().toFile(path.join(qa, 'Preview-268.png'));
    console.log(JSON.stringify(report, null, 2));
    assert(report.passed, 'Text contrast below 4.5:1; inspect Art/qa before retrying');
    fs.writeFileSync(path.join(root, 'Mod/About/Preview.png'), rendered);
  } finally {
    await browser.close();
  }
})().catch(error => { console.error(error); process.exitCode = 1; });
