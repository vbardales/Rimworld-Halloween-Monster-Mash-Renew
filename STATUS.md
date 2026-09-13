---
localization: complete
translation_en: complete
translation_fr: complete
settings_audit: not_applicable
mod:          Halloween Monster Mash Renew (unofficial)
packageId:    nelim.halloweenmonstermashrenew
repo:         Rimworld-Halloween-Monster-Mash-Renew
visibility:   public
detached:     yes
stage:        done
licence:      silent
port_licence: MIT (port additions only; see LICENSE)
licence_at:   upstream ships no LICENSE, and its Steam description says nothing about reuse
dependencies: declared
showcase:     complete
tested_on:
workshop:
remaining:
  - unverified: execute TF-01 through TF-10 in game; validate sugar correction with TF-05 and TF-06
  - unverified: record FR/EN interface and log checks, new-colony reload and TF-09 existing-save subcase; justify optional exclusions
session:      4d536aaf-96f0-461c-b97c-4a62e7d1e98b
updated:      2026-09-13, documentation and preview defects fixed and verified; done, awaiting in-game validation
---

# Halloween Monster Mash Renew — status

Lives at the root of the mod, never inside `Mod/`, so the Workshop uploader never receives it.
This thread maintains it.

## Current result after fixes — 2026-09-13

**`dansMonoRepo` -> `done`.** All cumulative gates through `done` are now established.
`done` means ready for final functional validation in game; it does not mean `tested`.
`tested_on` and `workshop` remain empty. HEAD is still
`70c10e89e1656f1688173cd3a6e7fb4035fc5fa9`; these fixes are local and uncommitted.
The pre-existing About.xml, README and STATUS edits were preserved and extended.
No push, publication, gameplay change or in-game test was performed.

### Resolved findings

- TESTS.md's active campaign and automated instructions are now in English. All ten
  scenarios, quantities, expectations and not-run results were preserved. TF-09 now
  explicitly covers a copy of an existing 1.6 save, separately from a new-colony reload.
  The historical technical notes were compared with HEAD and preserved verbatim apart
  from line endings. A new preface distinguishes superseded claims from active instructions.
- The Preview now has a two-line title, `Renew` at 65% in secondary ink, a separate
  `(unofficial)` tag and a `1.6` badge matching About.xml. Primary ink is shared by the
  main title and summary. The warm gold secondary follows the wood/lamplight family;
  the coral accent follows the red devil mask, clearly distinct from that gold.
  The brown veil is retained. Final colors have one source: Art/preview-palette.json.
- Art/Preview-text.html loads that palette directly. scripts/Render-Preview.cjs renders
  the local HTML with Playwright and checks loaded fonts, text bounds, suffix scale,
  version, PNG dimensions/size and contrast on the rendered text-free background.
  Art/Preview-text-before-audit.html preserves the earlier composition and measurement notes.
- README and About clarify VCE's required Harmony/VEF dependencies and changed recipe
  costs. The save-compatibility statement no longer claims an unperformed migration test.
  ATTRIBUTION clarifies direct versus transitive dependencies; LICENSE's scope description
  and the French recipe XML comment now match the root-loaded recipes. Distributed LICENSE
  and ATTRIBUTION copies were synchronized. Their licence terms and third-party exclusion
  were not changed.

### Verification of the delivered revision

- `node scripts/Render-Preview.cjs` passed with the bundled Node dependencies on NODE_PATH
  and the installed Chromium browser supplied by CHROME_PATH. No external network was used.
  Chromium's platform-font report confirms Segoe UI, Segoe UI Semibold and Segoe UI Bold,
  with no fallback. Font/image/palette readiness was awaited before capture.
- Direct visual review of Mod/About/Preview.png (896 x 504) and Art/qa/Preview-268.png
  confirmed readable title, suffix and version, distinct accent/secondary colors, no clipping
  or overlap, and an unchanged scene/camera. Minimum measured contrast across the full text
  rectangles is 5.835:1; badge contrast is 5.881:1. Final PNG: 522,080 bytes, below 1 MB.
  Evidence: Art/qa/preview-checks.json and Art/qa/Preview-background.png.
- `pwsh -NoProfile -File scripts/Test-CandyRecipes.ps1`: PASS for all six recipes.
- `pwsh -NoProfile -File ../scripts/Check-DefInjected.ps1 -TransMod ./Mod`:
  66 keys checked, zero errors. The only language-file change was a loading-layout comment.
- All nine distributed XML files parse; the exact final Source code on GitHub link remains
  intact. Root/distributed LICENSE and ATTRIBUTION hashes match. `git diff --check` passes.
- Gameplay Defs, textures and ModIcon were not changed. The successful field/reference/config
  checks, settings absence audit and full EN/FR inventory from the audit below remain valid.
  No build applies to this XML-only mod.

Final Preview SHA-256: `6DD57262B27CA1EC588272C294700BB97291A0C14E224413CF6935F15E8C4E79`.
Final About.xml SHA-256: `BB76446DCA0E4EF3526EC898DFEFBAB3947E06EC2ADD8469BACF23ED0D296F02`.
Original illustration SHA-256: `769480E1C9ED04613930A3049C0A12466CFB4E18F4C86C84E5E88A05152BA70A`.
ModIcon remains at its audit hash recorded below.

Next transition, `done` -> `tested`: execute applicable TF-01–TF-10 cases, including EN/FR
interface/log review and TF-09's two save cases; record real observations and justified
optional exclusions. No runtime success is inferred from the checks above.

## Historical workflow audit before fixes — 2026-09-13

The following audit findings describe the pre-fix state and are retained as evidence.
Its documentary and overlay blockers are resolved by the current result above.

The user-supplied nine-transition workflow takes precedence over PUBLISHING.md,
STYLE_RIMWORLD.md, MOD_SETTINGS.md and TRANSLATIONS.md, all read for this audit.
**Previous stage: `done`; retained stage: `dansMonoRepo`.** This is the workflow's
baseline code because the first cumulative gate is not fully satisfied. It does **not**
mean that the repository moved back into the monorepo: `detached: yes` remains true.
No remote needs restoring in the parent repository. All later independent results below
remain usable; none is a claim that a blocked cumulative stage has passed.

Audited standalone root: `C:\Users\nelim\Documents\rimworld\HalloweenMonsterMashRenew`.
Distributed root: its `Mod/` directory. HEAD and remote HEAD both resolve to
`70c10e89e1656f1688173cd3a6e7fb4035fc5fa9`. At audit entry, unstaged changes existed in
`Mod/About/About.xml` (+8/-6), `README.md` (+3/-1), and this file (+23/-2).
Those changes were preserved. This audit changes only STATUS.md; no development,
image generation, commit, push or publication was performed.

Entry SHA-256 values identify the local metadata and images actually inspected:

| File | SHA-256 |
| --- | --- |
| Mod/About/About.xml | `4A210E606176996A1F2D84D405D02CFEA5CA8AE5404BD9382B0164CBDFDE5AEF` |
| README.md | `A7AEC2A9B0F5627C7BB9F3C2BC9B3D268A497E9D8945DDFDF91B7B68CB98F3AA` |
| STATUS.md before this audit | `EB6D6A53F3DC28A32FE8F07D7B48A3D9D967059408E24683AD9727C9821E45C0` |
| Mod/About/Preview.png | `8E4774D45C805F6E48699432C16FF172D2EC3A248C5C70BCAF41E975D7AD572A` |
| Mod/About/ModIcon.png | `D6A4D49F63A23A6CAD164CC1AF006174C47946EEFBBD328F840FC6F4559C1B17` |

### Ordered transition findings

| Transition | Current evidence and result |
| --- | --- |
| dansMonoRepo -> horsMonoRepo | **Defect.** TESTS.md is tracked and its active automated-test instructions and TF-01–TF-10 campaign are in French. PUBLISHING.md requires repository documentation in English. Standalone Git root, origin, public GitHub repository and pushed HEAD were verified with `git rev-parse --show-toplevel`, `git remote -v`, `gh repo view ... --json name,isPrivate,url,defaultBranchRef`, and `git ls-remote origin HEAD`. README, ATTRIBUTION, LICENSE and CHANGELOG exist in English; distributed LICENSE and ATTRIBUTION copies are byte-identical. Names/packageId are coherent; the unofficial suffix does not require renaming the folder or repository. |
| horsMonoRepo -> ModIcon generated | **Independent artifact checks validated.** XML-only implementation: no C# project, assembly or pending build artifact; build is not applicable. Installed PNG is 128 x 128, 18,865 bytes. Direct inspection shows the mascot and Halloween object clearly. No unfinished implementation was found in the delivered content; runtime correctness remains unverified. |
| ModIcon generated -> Preview generated | **Independent artifact checks validated.** Installed PNG is 896 x 504, 531,294 bytes, below 1 MB. Direct inspection shows a high oblique room view, floor grid, small faceless colonist and legible title. No concrete camera defect found; a recorded screenshot comparison or generation history is not required. |
| Preview generated -> preOptions | **Defect.** The delivered image and Art/Preview-text.html leave `Renew` at full title size in primary ink instead of 65% in secondary ink. The `(unofficial)` tag and `1.6` badge required by the current overlay convention are absent. No title/tag secondary ink is implemented, so the required secondary/accent distinction is not established. About.xml description is English, has the correct initial unofficial notice and ends with the exact Steam-formatted Source code on GitHub link; its target matches origin, About URL and the verified repository. |
| preOptions -> options | **Independent audit: not applicable, justified.** See Settings audit below. |
| options -> l10n | **Independent checks validated.** 66 owned English source fields and 66 nonempty French entries; no missing/duplicate entries or parameter/tag mismatches found. DefInjected path checker passes. See Translation audit below. |
| l10n -> preTest | **Independent dependency checks validated.** VCE's installed packageId matches the mandatory dependency and loadAfter; it supports 1.6. VCE_RawSugar, VCE_Flour and VCE_Fruit resolve. All mod content loads from the root; no LoadFolders or conditional patches are needed here. Props as Style is an external optional consumer of four texture paths, not a required dependency. Its local LoadFolders gates Halloween on this packageId. No integration has been tested in game. |
| preTest -> done | **Independent test preparation/checks validated.** Ten scenarios have prerequisites, actions and expected results. Existing automated recipe and XML checks were executed successfully against current files; details below. Documentation language remains the earlier cumulative blocker. |
| done -> tested | **Non verified.** No scenarios were executed in game during this audit; existing results still say not executed. Logs, EN/FR UI, new-game behavior, save/reload and existing-save compatibility remain unverified. TF-09 covers saving the new test colony; an existing-save test is also needed for the compatibility claim. Optional Biotech/Props as Style cases need actual results or explicit justified exclusions. |

The next transition requires translating the active French documentation in TESTS.md,
without discarding its scenario content or historical results. It does not require
recreating the repository, rebuilding an XML-only mod or changing the parent remote.
After that, the independently identified Preview overlay defects still prevent preOptions.

### Settings audit

Inventory: eleven craftable masks (fixed stats, costs and natural generation), seven inert
buildings, six foods and six recipes. These are fixed content/balance definitions, not an
existing configuration system. Crafting quantities and ingredient choices use native bills;
wearing and eating use native game controls. The documented year-round mask generation and
trade behavior are deliberate balance choices. The mention of editing these constants in
ATTRIBUTION does not by itself justify inventing a new customization feature for this port.
No custom behavior, configurable service, settings serialization, inherited mod settings,
empty settings page or MainButtonDef is present in the complete source/distribution inventory.
No settings timing, scope, input bounds, persistence or shortcut tests apply.
Result: `settings_audit: not_applicable`. Under the user's explicit interpretation, source
verification suffices for this case. No RIMMSQOL or other customization integration is claimed
tested. This finding is independent of the pending gameplay tests.

### Translation audit

All four Def files and all four French DefInjected files were read. Owned texts consist of
48 ThingDef labels/descriptions (11 masks, 7 decorations, 6 sweets), plus 18 RecipeDef
labels/descriptions/jobStrings. Abstract bases add no other owned display strings. English
is supplied natively by the Def values; a redundant English language folder is unnecessary.
French text was reviewed alongside the source, including accents and meaning. A direct XML
inventory matched all 66 source fields to 66 nonempty French entries, checked duplicates
and brace/rich-text token parity, and reported zero errors. No owned formatting parameters,
grammar resources, Keyed strings, code UI, custom translated classes or patches were found.
Native generated crafting/ingestion UI uses the game's own mechanisms and translated labels.
`Check-DefInjected.ps1` checked 66 keys with zero errors and no unresolved targets.
The three `complete` fields certify resource readiness only; TF-08 and runtime formatting
remain unverified, as does all in-game testing.

### Executed technical checks

Environment: PowerShell 7 and installed RimWorld `1.6.4871 rev590` reference data/assemblies.
Commands are relative to the standalone repository; shared scripts are outside this repo.

| Check | Observed result |
| --- | --- |
| `pwsh -NoProfile -File ../scripts/Check-XmlFields.ps1 -ModPath ./Mod` | 5 files checked; no unknown 1.6 fields. |
| `pwsh -NoProfile -File ./scripts/Test-CandyRecipes.ps1` | PASS: six recipes, item counting, ingredient/fixed filters, products, work and both stoves. |
| `pwsh -NoProfile -File ../scripts/Check-ConfigErrors.ps1 -ModPath ./Mod` | 34/34 defs checked, 26 rules, no config errors. This is an offline subset of game rules, not a Unity run. |
| `pwsh -NoProfile -File ../scripts/Check-DefInjected.ps1 -TransMod ./Mod` | 66 keys checked, 0 errors. |
| `pwsh -NoProfile -File ../scripts/Check-DefRefs.ps1 -ModPath ./Mod -AlsoScan 'C:\Program Files (x86)\Steam\steamapps\workshop\content\294100\2134308519'` | 30 concrete defs, 4 parents; no unresolved or mistyped references. |
| Direct PowerShell XML parse / text inventory | All 9 distributed XML files parse; 66 EN/FR fields matched, no duplicate/missing translations or token mismatches. |
| Direct texture path check | 73 texture files; every texPath resolves to its PNG or stack-count folder, and all worn north/east/south paths exist. |
| PNG decode and metadata / distribution copies | Both images decode as PNG at expected sizes; LICENSE and ATTRIBUTION root/distribution hashes match. |

The chained checker run completed with exit code 0 and each checker reported its successful
result. The existing historical negative recipe test was not repeated; its earlier result is
preserved below. These checks do not establish successful cooking or game loading.

### Licence record and separate recommendations

`public` is verified live on GitHub. `silent` remains the documented workflow classification:
the installed original Workshop item 2257175849 declares only 1.2, its local description has
no reuse grant, and no licence file was found in that source. ATTRIBUTION records the prior
Steam investigation. This audit did not repeat a live Steam description/comment search;
no new permission or prohibition is asserted. MIT explicitly covers only port additions,
and both delivered notices preserve attribution and removal on request. This classification
does not establish permission to redistribute the original artwork.

Additional documentation findings, separate from the next gate's language correction:
README says all three dependencies were removed and that balance is untouched, contradicting
its VCE section and the current item-count recipes. About/README say no Harmony is required,
but the installed mandatory VCE declares Harmony and VEF as transitive dependencies; this
mod itself has no direct code dependency on them. Clarify that distinction rather than add
unused direct dependencies. The French recipe file's comment and LICENSE still mention the
removed conditional VCE layout; these comments do not change actual loading or translation.
Art/preview-palette.json is absent; record the palette when updating the overlay. None of
these observations justifies inventing a missing runtime failure or regenerating the scene.

## Historical record through 2026-09-12 (superseded by the audit above)

The following earlier status narrative and results are retained as history. Its old `done`
and showcase-complete statements are not the current cumulative workflow decision.

### Where the mod stood

Killer_Diller's **[KD] Halloween Monster Mash** carried to 1.6: eleven masks, seven decorations,
six sweets, all keeping their original defNames. XML only, no assembly, no Harmony. Tagged 1.0.0
on 2026-09-11. English and French.

The port is complete and the showcase is done — `Mod/About/Preview.png` and `ModIcon.png`, with
their full-resolution sources kept in `Art/` outside `Mod/`. What is left is the one thing this
repository cannot supply: nobody has watched it run. `tested_on` stays empty and `workshop` stays
empty until then, which is what the changelog already says out loud.

The functional test campaign is written in `TESTS.md`: ten manual scenarios with prerequisites,
steps, expected results and a results table. They cover loading and dependencies, mask crafting
and wearing, protection, decorations, sweet recipes and ingredient restrictions, consumption,
French translation, save/reload, and optional Props as Style integration. Scenario writing is
complete, including updated item-count expectations for TF-05. All ten scenarios remain
unexecuted: the functional test campaign itself is not complete and no in-game pass is claimed.

The six sweet recipes now count items instead of nutrition to address the suspected sugar
blocker. Ingredient numbers, work and output are unchanged, but actual costs change. The
original failure was not reproduced in game. Static checks passed: all nine XML files parse,
and all six recipes retain the expected partner counts, four sugar, ten output items and
450 work, with the nutrition getter removed. These checks do not establish in-game success.

Reproducible automated checks passed on 2026-09-12: the shared
`../scripts/Check-XmlFields.ps1` reports five files with no unknown RimWorld 1.6 fields;
`scripts/Test-CandyRecipes.ps1` verifies all six recipes, including ingredient filters and
both stoves. A temporary copy with nutrition counting restored was rejected as expected.
Commands and prerequisites are documented in TESTS.md. Automated checks are complete for
this recipe change; the manual functional campaign remains pending.

Next: execute TF-01 through TF-10 on RimWorld 1.6, recording any inapplicable optional cases.
Prioritize TF-05 and TF-06 to validate cooking, exact consumption on both stoves, ingredient
restrictions and resumption. Record exact game/mod versions, observations and Player.log in
the TESTS.md results table. Fill tested_on only after an actual game run.

## What the four unreadable fields mean here

- **`stage: done`** — complete and untested. The run in game is not a manufacturing step; it is
  said by `tested_on` and `workshop`.
- **`tested_on`** — empty. Never launched.
- **`dependencies: declared`** — Vanilla Cooking Expanded is the single dependency, named in
  `modDependencies` and in `loadAfter`. The two other Vanilla Expanded mods upstream declared are
  referenced by none of its defs and were dropped.
- **`remaining`** — in-game execution of the written scenarios, including sugar correction
  validation; scenario writing and the code correction are complete.

## Why `licence: silent`

The field describes the debt owed upstream, not this repository's own terms. Killer_Diller
published no licence and the mod has not moved since 13 October 2020, so the source is dead and
silent. The `LICENSE` at the root is MIT and covers the port work alone.

`licence` vocabulary: `open` an explicit licence, `silent` no licence and a dead source, `alive`
no licence but a living source, `forbidden` a written refusal, `original` owing nothing to anyone.

## Publication and test audit — 2026-09-12

- Title: `Halloween Monster Mash Renew (unofficial)`. The suffix is already present in
  About.xml, README.md and this file, as required by the local publication convention for
  the documented public/silent status. The unofficial notice is present too.
- Manual tests: ten scenarios TF-01 through TF-10 exist in TESTS.md with steps and expected
  results. All ten remain unexecuted in game.
- Automated checks rerun successfully: Check-XmlFields (5 files, no unknown 1.6 fields),
  Test-CandyRecipes (6 recipes), Check-ConfigErrors (34/34 defs, 26 rules, no errors),
  Check-DefRefs with installed VCE (30 defs, 4 parents, no missing or mistyped references),
  and Check-DefInjected (66 French keys, no errors).
- About.xml parses after the description update. Its description now ends with the Steam
  formatted `Source code on GitHub` link matching the repository URL and git origin.
- Licence recorded by the repository: upstream remains `silent`; MIT covers only the port
  additions described in LICENSE. It does not license Killer_Diller's original content.
  This audit checks the existing local record, not a fresh upstream permission investigation.

## Repository location

One remote, `origin`, at https://github.com/vbardales/Rimworld-Halloween-Monster-Mash-Renew.
Detached from the `Documents/rimworld` monorepo on 2026-09-12.
