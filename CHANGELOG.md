# Changelog

Format inspired by [Keep a Changelog](https://keepachangelog.com/en/1.1.0/).
This file serves the repository and the writing of Steam patch notes; RimWorld does not display it
in game.

## [Unreleased]

### Fixed

- Workshop preview overlay now distinguishes the Renew suffix, includes the unofficial tag
  and 1.6 badge, and uses a checked shared palette. The illustration is unchanged.
- Test documentation is now in English; existing-save checks are explicit and all in-game
  results remain pending. Dependency and recipe-balance descriptions were clarified.

- Six sweet recipes now count individual items instead of nutrition to address the suspected
  zero-nutrition sugar blocker. Each batch requires 4 sugar plus 4 unfertilized eggs,
  4 chocolate, 25 fruit, 4 raw animal products (such as milk), 40 flour or 40 corn,
  respectively. Output remains 10 sweets and work remains 450. This changes ingredient
  balance. Cooking and actual consumption still require in-game validation (TF-05/TF-06).

## [1.0.0] — 2026-09-11

First release. Not yet on the Steam Workshop: this tags the source, and the Workshop item follows
once the mod has been tried in a running game.

Killer_Diller's **[KD] Halloween Monster Mash**, uploaded 13 October 2020 and never updated,
carried to 1.6. The original is not merely out of date: it declares no `LoadFolders.xml` and keeps
every def in a `1.2/` folder, so in 1.6 not one of its defs loads.

### Added

- **The eleven masks** — devil, clown, witch, Frankenstein, mummy, wolfman, hockey, skull, zombie,
  cat, pirate hat — with their original defNames and their forty-four textures.
- **Seven decorations** — fake spider, ghosts, bats, skeleton, reaper, haunted tree, unlit carved
  pumpkin — with their original defNames.
- **Six sweets and their six recipes** — bloodshot cake pops, coffin bars, spider bites, brain
  cakes, murder buns, candy corn.
- All seventy-three textures, including the four decorations this mod does not build (gargoyle,
  lit jack-o-lantern, cauldron, candle), which Props as Style reads from here.
- Vanilla Cooking Expanded declared as a dependency, as upstream did — but as the only one.
- French translation of everything. The original shipped none.

### Changed

- **The masks protect for the first time.** Each declared `costStuffCount` and the three
  `StuffEffectMultiplier*` stats of a vanilla cloth hat, but no `stuffCategories` — and none of
  `HatMakeableBase`, `ApparelMakeableBase`, `ApparelBase` or `ApparelNoQualityBase` declares any
  either. `MadeFromStuff` was false, so all four lines were inert; with no `ArmorRating_*` or
  `Insulation_*` set in their place, protection was zero against eleven descriptions promising
  otherwise. Replaced by the flat values the multipliers would have produced on cloth:
  `ArmorRating_Sharp` 0.072, `ArmorRating_Heat` 0.036, `Insulation_Cold` 1.8, `Insulation_Heat`
  0.9. Adding `stuffCategories` instead would have tinted the painted artwork with the colour of
  the cloth.
- `developmentalStageFilter` set to `Child, Adult` on every mask, as vanilla headgear does.
- **Two of the three declared dependencies are gone.** The six recipes genuinely need Vanilla
  Cooking Expanded — its sugar, and its flour and fruit for three of them — so it stays declared.
  Vanilla Plants Expanded and the Vanilla Expanded Framework are referenced nowhere in the
  original's defs and are not carried over.
- `HMM_Make_BrainCakes` was labelled `make Bloodshot Brain Cakes`, a copy-paste from the cake pops
  recipe above it in the source file. It makes brain cakes.
- Twenty-six near-identical defs folded onto `HMM_MaskBase`, `HMM_PropBase` and `HMM_CandyBase`,
  and the six recipes onto `HMM_MakeCandyBase`. Every value is the author's.
- Labels lower-cased to the vanilla convention throughout; `Jackolantern` spelled `jack-o-lantern`.
- Typos fixed in six mask descriptions, two sweet descriptions (`a bunch sweet gummies`,
  `made with nugget`), and two decoration descriptions missing a full stop.

### Removed

- **Two of the three Vanilla Expanded dependencies.** Vanilla Plants Expanded and the Vanilla
  Expanded Framework are referenced nowhere in the original's defs; they were declared in error.
  The third, Vanilla Cooking Expanded, is genuinely used and stays declared.
- **Four decorations, as buildings.** The gargoyle, the lit jack-o-lantern, the cauldron and the
  candle are shipped as textures only; Props as Style dresses `SculptureSmall`, `TorchLamp`,
  `Campfire` and `Brazier` in them. This loses the refuellable light, the heat and the meditation
  focus the last two had as buildings — the vanilla defs underneath provide their own.
- `costStuffCount`, inert without `stuffCategories`. The `costList` of 30 cloth is what the mod
  always actually charged, and it is unchanged.
- `<thingCategories Inherit="False">`, identical to what `HatMakeableBase` already sets.
