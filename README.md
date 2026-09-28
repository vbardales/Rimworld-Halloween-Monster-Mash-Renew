# Halloween Monster Mash Renew (unofficial)

UNOFFICIAL. This mod is published without the original author's explicit consent. If the original author contacts me to request its removal, I undertake to take it down promptly.

**[KD] Halloween Monster Mash** (Killer_Diller), carried to RimWorld 1.6 — eleven masks, seven
decorations and six Halloween sweets. Vanilla Cooking Expanded remains required; Vanilla Plants
Expanded became optional (it only adds the spider bites recipe); one unused direct dependency
declaration, the Vanilla Expanded Framework, was removed.

**I am not the author of this mod.** The artwork and the original idea are entirely
Killer_Diller's — all I did was the work needed to make them run on 1.6. Credit goes to them;
mistakes in the port are mine.

Original mod: https://steamcommunity.com/sharedfiles/filedetails/?id=2257175849 (stays on 1.2,
uploaded 13 October 2020, never updated). The page is still online; the mod is abandoned, not
withdrawn.

## Why this exists

The original does not merely lag behind 1.6 — it is **inert** in it. It declares no
`LoadFolders.xml` and keeps every def in a folder named `1.2/`, and RimWorld 1.6 reads only the
root. Not one of its defs loads. Its textures do, because they sit at the root, which is the whole
reason Props as Style was able to point four styles at artwork whose objects no longer existed.

This port brings the defs back.

## What the mod does

**Eleven headpieces** — devil, clown, witch, Frankenstein, mummy, wolfman, hockey, skull, zombie,
cat, and a pirate hat. Each costs 30 cloth, takes no research, and is made at a hand or electric
tailoring bench, or at a crafting spot. They sit on the overhead layer over the upper head, so they
compete with hats rather than with helmets, and each is drawn on the pawn from all four sides.

**Seven decorations** — fake spider, ghosts, bats, skeleton, reaper, haunted tree, unlit carved
pumpkin. Five wood each, from the Misc tab, no research, no power, no material choice. Pure props:
`Beauty 1` and nothing else.

**Six sweets** — bloodshot cake pops, coffin bars, spider bites, brain cakes, murder buns, candy
corn. Vanilla chocolate with a different sprite and a different amount of recreation, cooked ten at
a time at a stove.

No DLC required. This mod is XML only and ships no assembly or direct Harmony integration.
Its required dependency, Vanilla Cooking Expanded, also requires Harmony and Vanilla Expanded
Framework; install those dependencies as well.

Available in English and French.

Content mod: removing it mid-save destroys anything already built or crafted from it.

## Requires Vanilla Cooking Expanded

All six recipes call for `VCE_RawSugar`, and one also wants `VCE_Flour`, so
[Vanilla Cooking Expanded](https://steamcommunity.com/sharedfiles/filedetails/?id=2134308519)
is a declared dependency.

Only the sweets need it — the masks and the decorations are plain vanilla content. An earlier
build isolated the recipes in a `Mod/VCE/` folder rooted by `LoadFolders.xml`, so the mod ran
without Vanilla Cooking Expanded and merely lost them; that was dropped in favour of a plain
dependency.

## Optional: Vanilla Plants Expanded

The `VCE_Fruit` category that the spider bites recipe asks for is defined by
[Vanilla Plants Expanded](https://steamcommunity.com/sharedfiles/filedetails/?id=2134308522), not
by Cooking Expanded (neither mod depends on the other). The recipe carries
`MayRequire="VanillaExpanded.VPlantsE"`, and Plants Expanded is in `loadAfter`: without it that
one recipe is absent and nothing else changes; with it, the recipe works as in the original. The
spider bites item exists either way.

The original declared three dependencies: Cooking Expanded (required here), Plants Expanded
(optional here) and the Vanilla Expanded Framework. Only the Framework's direct declaration was
removed, since no def of this mod references it; it is still required transitively by Vanilla
Cooking Expanded.

## Four decorations are missing on purpose

The gargoyle, the lit jack-o-lantern, the cauldron and the candle are not buildings here. They ship
as vanilla styles in **Props as Style**, dressing a small sculpture, a torch lamp, a campfire and a
brazier — so they keep behaviour a decoration cannot have. Their textures live in this mod, and
that is where Props as Style reads them from.

What the trade costs: upstream those last two were real buildings — refuellable, lighting a radius
of ten, pushing heat, serving as a flame meditation focus. As styles that behaviour comes from the
vanilla torch and brazier underneath, not from the pumpkin. See `ATTRIBUTION.md`.

## What changed in the 1.6 port

- **The masks now actually protect.** Every one declared a stuff cost and three stuff-effect
  multipliers without ever declaring what stuff it was made of — and nothing in the ancestry
  declares any either. All four lines were inert, and the "mediocre protection against cold and
  damage" promised by eleven descriptions came to exactly zero. Replaced by the flat values the
  multipliers were meant to produce on cloth.
- **`developmentalStageFilter`** — `Child, Adult`, which every vanilla hat carries and none of
  these did.
- **Dependencies sorted.** Vanilla Cooking Expanded is used by all six recipes and stays
  declared; its own dependencies still apply. Vanilla Plants Expanded is used by one recipe
  only and is optional (`MayRequire`). The Vanilla Expanded Framework is not referenced by this
  mod's defs, so its direct declaration was removed.
- **One recipe was labelled `make Bloodshot Brain Cakes`** — a copy-paste from the recipe above it.
  It makes brain cakes.
- **Repeated defs folded onto shared bases** — `HMM_MaskBase`, `HMM_PropBase`, `HMM_CandyBase`,
  plus `HMM_MakeCandyBase` for recipes. Mask protection and recipe counting changes are
  documented separately.
- **Labels lower-cased** to the vanilla convention, and a handful of typos fixed.

The retained defNames are unchanged to preserve item references in existing saves.
Save compatibility still requires the checks in `TESTS.md`; unchanged identifiers alone do
not establish migration from RimWorld 1.2. Do not load the original and this port together.

Recipe costs changed after 1.0.0: counts now mean individual items rather than nutrition.
Each batch uses 4 sugar plus 4 eggs, 4 chocolate, 25 fruit (Plants Expanded's), 4 raw animal products (such as milk),
40 flour or 40 corn, respectively. Output remains ten sweets and work remains 450.
Actual cooking and consumption are awaiting in-game validation.

The author's year-round mask generation and the sweets' lack of trade tags remain unchanged.
`ATTRIBUTION.md` records these fixed balance choices.

## Layout

```
Mod/About/                              metadata
Mod/Defs/ThingDefs_Misc/                masks, decorations, sweets
Mod/Defs/RecipeDefs/                    the six cooking recipes
Mod/Languages/French/DefInjected/       translation
Mod/Textures/                           taken as-is from upstream, all seventy-three
Art/                                    showcase sources and the sheet that engraves it;
                                        RimWorld never reads this folder
```

## Licence

MIT for the port work; the artwork is Killer_Diller's and carries no licence. See `LICENSE` and
`ATTRIBUTION.md`.

## Rebuilding the preview

The existing illustration is preserved in `Art/Preview-source.png`. Edit the composition in
`Art/Preview-text.html` and its single palette source, `Art/preview-palette.json`, then run
`node scripts/Render-Preview.cjs` with `playwright` and `sharp` available on Node's module path.
Set `CHROME_PATH` to a Chromium browser executable if no Playwright browser is installed.
The renderer uses local assets only, verifies Segoe UI, layout, supported version and contrast,
and installs `Mod/About/Preview.png` only after its checks pass. Inspect the full image and
`Art/qa/Preview-268.png` visually too; machine checks do not replace visual review.
