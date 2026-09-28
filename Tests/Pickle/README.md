# Pickle suite: Halloween Monster Mash Renew

Development only, never published, kept outside `Mod/`. Written on 2026-09-28 against Pickle's own step
catalogue (fetched from GitHub main that day, **not established as the version staged in the WSL**),
PickleTools' catalogue and the shared authoring guide. **None of it has been run.** The suite has no C#
steps: everything it says is Pickle's own vocabulary, plus two optional PickleTools companions
(`LoadAudit`, `TextureOwner`).

`Check-Steps.ps1` checks the vocabulary offline, so a run is not lost to an undefined step:

```powershell
gh api repos/RimWorks/Rimworld-Pickle/contents/Docs/steps.md --jq .content | base64 -d > $env:TEMP\pickle-steps.md
powershell -File Tests/Pickle/Check-Steps.ps1 -PickleCatalogue $env:TEMP\pickle-steps.md
```

Result on 2026-09-28: 11 features, 85 step lines, 0 problems; a
negative control (an undefined step, a truncated step, a non-numeric value, a placeholder with no column)
was reported four times out of four.

## What needs a running game, and what does not

The offline scripts in `scripts/` and the shared checkers (`Check-DefRefs`, `Check-XmlFields`,
`Check-ConfigErrors`, `Check-DefInjected`, `Check-XmlClasses`, `Check-TypeRefs`) read the XML. They prove
every recipe counts items, every texture path has a file, the French keys resolve. What they cannot do:

- see a category that **no loaded mod defines**: `Check-DefRefs` does not resolve the `<categories>` of an
  ingredient filter, and reported `VCE_Fruit` as fine on 2026-09-28 although only Vanilla Plants Expanded
  defines it (proved by replacing it with `VCE_Bogus`: still no report). `01-load.feature` does, because
  the game logs it at startup and LoadAudit reads the log from the start;
- show that a colonist really fills a bill from item counts (`06-sweets-cooking.feature`), the one place the
  mod's earlier defect lived;
- show that the game **computes** the mask protection and the sweets' joy from the merged XML
  (`02`, `10`, at the main menu, seconds);
- show a mask or a prop drawn (`03`, `05`, `@review`), and that a save keeps them (`07`).

Not written, with the reason, and listed again in `TESTING.md`: the four facings of a mask (no Pickle step
turns a pawn), sweet stacks at 1, 25 and 75 (a picture, no step sets a stack), a copy of an older save that
holds HMM items (none exists), the layout of the crafting menus in French (no capture written).

## Passes

`<suite>` is the companion's display name, `Halloween Monster Mash Renew - Pickle tests`. A complete pass
is `-Filter '<suite>,!@lang-fr'` (or `!@lang-en`), which the launcher treats as a full run (120 minutes).

| Pass | Command shape | Establishes | Skipped by requirement |
|---|---|---|---|
| sans-facultatifs, English | `-DepMap wsl-deps.sans-facultatifs.map -Filter '<suite>,!@lang-fr'` | The mod beside Vanilla Cooking Expanded alone. `01-load` is **expected red today**. | spider bites (needs VPE), `09` |
| sans-facultatifs, French | the same, `-Language French -Filter '<suite>,!@lang-en'` | The French labels the game resolved | the same |
| avec-vpe | `-DepMap wsl-deps.avec-vpe.map -Filter '<suite>,!@lang-fr'` | The category `VCE_Fruit` exists, so the sixth recipe can be cooked and the load is clean | `09` |
| avec-props-as-style | `-DepMap wsl-deps.avec-props-as-style.map -Filter '09-props-as-style-textures'` | This mod answers for the four textures Props as Style reads | none |
| incompat-original | **not written**, see `TESTING.md` | Whether "do not load the original with this port" is still true | |

The maps name Vanilla Expanded Framework before Vanilla Cooking Expanded because the staging copies only
the tested mod's own direct dependencies and its order is the load order. **Not read for the last map:**
Props as Style's own dependencies (its About.xml names Ideology); if the staging stops, the missing line
belongs there. Expected counts for a first read of the English pass: 57 scenarios discovered, 3 French ones
excluded by the filter, 5 skipped by requirement, 49 played. Read `exitReason` before any number.

## Two things this suite assumes and has not seen

1. **A fixture colonist refuels the stove.** `06` builds a `FueledStove`, spawns wood in the stockpile and
   relies on a colonist doing the refuelling. If none does, the bill never starts and the wait ends the run.
   The fallback is a local step; `FlavorTextExtendedFR` has one (`a fuelled stove stands at`).
2. **`def ... field "ingestible.joy"` is rendered as `0.15`.** A red that reads the right number in another
   format is the step's, not the mod's.

## Evidence

Reports go to `Tests/Pickle/Evidence/<run>/` through the launcher's `-EvidenceDir`. That folder is ignored
by git, like `evidence/`. What to keep after a run, how to minify it and what to delete is in `TESTING.md`,
section "Evidence".
