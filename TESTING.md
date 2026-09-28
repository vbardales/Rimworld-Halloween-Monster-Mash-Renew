# Testing

How this mod is tested, which passes it needs, where each manual scenario went and what evidence is kept.
Nothing in a running game has been done yet: every in-game line below is `unverified`, not a pass.
Written on 2026-09-28 against `AUDIT.md` (blob `e9a564da92`, read whole) and the shared authoring guide.

## Layers

| Layer | Where | Runs | Proves |
|---|---|---|---|
| Recipe contract | `scripts/Test-CandyRecipes.ps1` | offline | Six recipes, item counting (no nutrition getter), ingredients and fixed filters, products, work, both stoves. |
| Shared XML checkers | `../scripts/Check-*.ps1` | offline | Fields, config errors, def references, `Class=`, type references, DefInjected keys. **`Check-DefRefs` does not resolve the `<categories>` of an ingredient filter**, see `STATUS.md`. |
| Step vocabulary | `Tests/Pickle/Check-Steps.ps1` | offline | Every step of the suite exists in Pickle's and PickleTools' catalogues. |
| Pickle | `Tests/Pickle/` | in game | The load, the game-computed values, cooking, drawing, save and reload. See `Tests/Pickle/README.md`. |

## Passes a full validation needs

The mod has one hard dependency, Vanilla Cooking Expanded, and two integrations: Vanilla Plants Expanded
(where the `VCE_Fruit` category lives, see `STATUS.md`) and Props as Style (which reads four textures).
Neither integration excludes the other, but each is its own pass because each mounts a different mod.

1. **sans-facultatifs, English**: `-DepMap wsl-deps.sans-facultatifs.map`, filter `'<suite>,!@lang-fr'`.
2. **sans-facultatifs, French**: the same with `-Language French` and `'<suite>,!@lang-en'`.
3. **avec-vpe**: `-DepMap wsl-deps.avec-vpe.map`, filter `'<suite>,!@lang-fr'`. English only: the text
   does not change with the mod, and the French labels are read in pass 2.
4. **avec-props-as-style**: `-DepMap wsl-deps.avec-props-as-style.map`, filter
   `'09-props-as-style-textures'`.
5. **incompat-original**: **no pass and no scenario yet.** `README.md` and the Steam description say "do not
   load the original and this port together", which is a claim, and it ages. The original
   (`KD.HalloweenMonsterMash`, 2257175849) ships every def in a `1.2/` folder with no `LoadFolders.xml`, so in
   1.6 none of its defs loads and only its textures do: it may well be harmless beside this port. The first
   thing to do is mount it once (with Vanilla Plants Expanded, which it declares) and **observe** the
   symptom, then assert that symptom (`an error matching ... was logged` under `@allow-errors`, or
   `no errors were logged` if there is none) and correct the README if the warning is false. The About.xml
   declares no `incompatibleWith`, so this is an unverified statement rather than a declared conflict.

A DLC-absent pass is not needed: the mod names no DLC and guards none. Languages other than English and
French are not claimed.

## The ten manual scenarios, and where each one went

`TESTS.md` keeps the detailed description. For `tested`, none may remain a manual check to tick: each is
automated and green, or listed here as not applicable with its reason, or listed as **open**.

| # | Scenario | Disposition |
|---|---|---|
| TF-01 | Loading and dependency | Pickle `01-load`, passes 1 to 3. Expected red in pass 1 until the `VCE_Fruit` defect is settled. The "VCE disabled" subcase is not applicable: the game's own dependency warning, not this mod's code. |
| TF-02 | Crafting eleven masks at three workstations | Pickle `04`: one full craft at the crafting spot, and the two tailoring benches by adding the bill. **Not** eleven masks times three benches: they share one `recipeUsers` list, and the offline XML checks show it. |
| TF-03 | Wearing, orientations, protection | Pickle `02` (the four stats the game computes, all eleven masks) and `03` (worn, drawn, `@review`). The **four facings are open**: no step turns a pawn; the 44 texture files are a file contract checked offline. The child subcase needs Biotech and is **open**: the fixture's colonists are adults. |
| TF-04 | Seven decorations | Pickle `05` (built, drawn, `@review`). Crossing a tile is not applicable: `passability` is a def field the game's own pathing reads. |
| TF-05 | Cooking six sweets | Pickle `06`, five recipes in passes 1 and 3, the sixth in pass 3 only. Needs the colonist-refuels-the-stove assumption, see the README. |
| TF-06 | Missing or excluded ingredients | **Not applicable**: a bill that lacks an ingredient does not start is the game's own bill logic, not this mod's. What the mod owns is that the ingredients are the right ones, and `06` shows it fills. The 29-cloth case is the same argument. |
| TF-07 | Sweet graphics, stacking, consumption | Joy values: Pickle `10`. Consumption and hauling are the game's. **Open:** the sprites at stacks of 1, 25 and 75 (`Graphic_StackCount` picks by count) is a picture, and no step sets a stack; the 18 files are a file contract checked offline. |
| TF-08 | French and back to English | Pickle `08` in two passes (three labels, one of each kind). **Open:** clipping and formatting in the game's menus, which needs a capture of a window that no scenario is written for. The mod has no Keyed text, so LoadAudit's translation check has nothing to compare. |
| TF-09 | Saving and reloading | Pickle `07`. **Open:** loading a copy of a 1.6 save made before these changes and holding HMM items: none exists, and the test companion cannot remove the mod to make one. Migration from a 1.2 save is a different claim and is not made. |
| TF-10 | Props as Style | Pickle `09` in pass 4: the texture contract from this mod's side. Props as Style has **no Pickle suite**, so the styles themselves (fuel, light, heat on the vanilla buildings) are open and belong to its repository. |

## What `tested` needs, in addition to `done`

Stated by the owner on 2026-09-28, in the terms of `AUDIT.md`, step `done -> tested`:

- **No scenario in `@wip`.** None is tagged so today: a scenario set aside is repaired and replayed, or
  deleted with its reason written here.
- **Every conditional scenario has run**, with the mod it needs mounted, and its report was read (suite name
  and scenario names checked before quoting it: the reports folder is shared by the whole machine). The
  conditions today: `@requires:nelim.pickletools.loadaudit` (passes 1, 2, 3), `@requires:VanillaExpanded.VPlantsE`
  (pass 3), `@requires:nelim.propsasstyle` and `nelim.pickletools.textureowner` (pass 4). A scenario skipped
  for want of its condition is not a scenario passed: compare played against discovered in every report.
- **No manual test left to validate.** Every row above is green, or listed as not applicable with its
  reason, or the **open** items are settled. The `@review` captures are still to be opened and looked at,
  but that is reading an image a scenario has already put in the intended state, not one more manual test.
- `exitReason` read before any count; a red is not automatically the mod's (a fixture without a cook, a
  stove nobody refuels, a language forgotten), and the causes are ruled out first.

## Evidence

Reports land in `Tests/Pickle/Evidence/<run>/` through the launcher's `-EvidenceDir` (a new folder each
time, never the same twice). The folder and `evidence/` are ignored by git; nothing of a run is committed
except **one text line** in `docs/runs/history.md`, cited by `STATUS.md`.

After each run, read `exitReason` and the played-against-discovered count, then keep only:

- the **latest report for the revision now in the repository**, per pass: `summary.json`, `summary.md` and
  `junit.xml`. Delete `report.html`, `messages.ndjson` and any earlier report of a superseded build;
- an **older report only if it is the sole proof of a check the latest run did not repeat**;
- the **`@review` captures that were actually opened and judged**, **minified**: the eleven masks worn and the
  seven decorations built are kept as two contact sheets, not eighteen files (the originals are deleted once
  the sheets are built):

  ```bash
  # capture names are the strings given to "I take a screenshot", e.g. "HMM_Mask_Devil worn"
  ffmpeg -pattern_type glob -i "Evidence/<run>/*worn*.png" -vf "scale=448:-1,tile=4x3" -frames:v 1 masks-sheet.png
  ```

  Any capture that shows a defect is kept whole, whatever its size. Captures over a megabyte are scaled to
  896 pixels wide;
- the `Player.log` only of a red run, cut to the lines around the failure.

Before deleting, list what goes and what stays. Never delete a file `STATUS.md` still points to: repoint
it first. A report about a superseded build proves nothing about the current one. On Windows, a capture
name longer than MAX_PATH stops `Remove-Item`; empty the folder with `robocopy <empty> <target> /MIR` and
remove the shell that remains.
