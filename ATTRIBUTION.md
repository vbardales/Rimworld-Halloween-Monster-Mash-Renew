# Attribution

## [KD] Halloween Monster Mash

- **Original author:** [KD] Killer_Diller
- **Source:** Steam Workshop `2257175849`, last supported version 1.2, uploaded 13 October 2020 and
  never updated since — https://steamcommunity.com/sharedfiles/filedetails/?id=2257175849
  The page is still online. The mod is abandoned, not withdrawn.
- **Reused here:** the eleven masks, seven of the eleven decorations, and the six sweets with their
  six recipes — their defs and all seventy-three textures. Four decorations are shipped as
  **textures only**: the gargoyle, the lit jack-o-lantern, the cauldron and the candle are rebuilt
  as vanilla styles by Props as Style, which reads them from this mod.

The author has three Workshop items, all for RimWorld, and none has been touched since
13 May 2021.

## Licence

**No licence is declared**: there is no `LICENSE` file in the mod, and its Steam description says
nothing about reuse. The mod is republished under the usual practice for abandoned mods —
explicit credit, a link to the original, and removal on request. That is stated in the mod's own
description, not only here.

If Killer_Diller asks for this to be taken down, it comes down. Immediately, and without
discussion.

## Why the original is dead, and not merely old

It declares 1.2, ships no `LoadFolders.xml`, and keeps every def in a folder named `1.2/`.
RimWorld 1.6 reads only the root, so **not one of its defs loads**. Its textures, however, sit at
the root and load normally — which is why Props as Style was able to point styles at them while
the objects themselves no longer existed in any colony. This port is what makes the defs come back.

## The three dependencies, and what became of them

The original declares Vanilla Cooking Expanded, Vanilla Plants Expanded and the Vanilla Expanded
Framework. Reading its four def files, **only the first is used anywhere**: the six recipes call
for `VCE_RawSugar`, and three of them also want `VCE_Flour` or the `VCE_Fruit` category. Nothing
references Vanilla Plants Expanded or the Framework. Those two were declared in error and are gone.

**Vanilla Cooking Expanded is declared as a dependency**, as upstream did. The six recipes sit in
`Mod/Defs/RecipeDefs/` with the rest and name `VCE_` defs without a guard, which is safe because
those defs are always present.

An earlier build of this port isolated them instead: the recipes lived in `Mod/VCE/`, rooted by
`LoadFolders.xml` on `IfModActive="VanillaExpanded.VCookE"`, so the mod ran without Vanilla
Cooking Expanded and merely lost the ability to cook the sweets. That was dropped on the port
author's decision, in favour of the plain dependency. Two things from it are worth keeping on
record in case it is ever reinstated:

- It was conditioned **as a folder, not def by def**. A `RecipeDef` whose ingredient filter names
  a thing that does not exist does not degrade quietly — it throws, and takes its whole file with
  it. `MayRequire` on the individual defs would not have been equivalent.
- The alternative considered and rejected was to rewrite the six recipes in vanilla ingredients.
  That would have invented balance the author never wrote.

## The four decorations that are textures only

The gargoyle, the lit jack-o-lantern, the cauldron and the candle are **not** rebuilt as buildings
here. Props as Style dresses four vanilla defs in them — `SculptureSmall`, `TorchLamp`, `Campfire`
and `Brazier` — and reads the textures out of this mod. Building them here as well would put the
same four objects in the game twice.

What that costs is worth stating, because it is a real loss. Upstream, the **lit jack-o-lantern**
and the **candle** were not props at all: they were full buildings with `CompProperties_Refuelable`,
a `Glower` of radius 10, a `HeatPusher`, and a `CompProperties_MeditationFocus` carrying a
`FocusStrengthOffset_Lit`. As styles, none of that survives — it is the vanilla torch and brazier
underneath that light the room and hold the flame focus. Anyone wanting those two back as
buildings has to extract them, not style them.

The seven kept here — spider, ghosts, bats, skeleton, reaper, haunted tree, unlit pumpkin — have no
vanilla twin, which is exactly why they could not become styles. They are the purest props in the
mod: `Beauty 1`, five wood, no material, no component, no comp of any kind.

## What the port changed — the masks

| Point | Decision |
|---|---|
| `costStuffCount` + three `StuffEffectMultiplier*` stats, with no `stuffCategories` | Replaced by flat stats. See below — this is the one real defect. |
| No `developmentalStageFilter` | Added `Child, Adult`, which every vanilla hat carries. |
| `costStuffCount>30</costStuffCount>` alongside `<costList><Cloth>30</Cloth></costList>` | The `costList` is kept; `costStuffCount` is dropped as inert. |
| `<thingCategories Inherit="False"><li>Headgear</li>` | Dropped: identical to what `HatMakeableBase` already sets. |
| Eleven near-identical defs | Folded onto a local `HMM_MaskBase`. Each mask now declares only its name, label, description and two texture paths. |
| Title-case labels (`Devil Mask`) | Lower-cased, as vanilla does throughout. RimWorld capitalises the first letter itself. |
| `AA mask made out of cloth`, `reggedy`, `look like clown`, `look like werewolf`, `Tonights not a full moon right?`, `Dios De Los Muertos` | Fixed. |

Checked against RimWorld 1.6.4871.

### The masks protected nothing

Every mask carried the stat block of a vanilla cloth hat:

```xml
<costStuffCount>30</costStuffCount>
<statBases>
  <StuffEffectMultiplierArmor>0.2</StuffEffectMultiplierArmor>
  <StuffEffectMultiplierInsulation_Cold>0.1</StuffEffectMultiplierInsulation_Cold>
  <StuffEffectMultiplierInsulation_Heat>0.05</StuffEffectMultiplierInsulation_Heat>
</statBases>
```

...and never declared `stuffCategories`. Neither does anything above it: `HatMakeableBase` →
`ApparelMakeableBase` → `ApparelBase` → `ApparelNoQualityBase` declare none. `MadeFromStuff` is
therefore false, the four lines above are inert, and since the defs set no `ArmorRating_*` or
`Insulation_*` of their own, every mask offered **zero** protection — while eleven descriptions
promised "mediocre protection against cold and damage". The cost came from the `costList` beside
it, which is why the mod still cost the 30 cloth its Steam page advertises, and why nothing ever
looked wrong.

The multipliers are the vanilla hat block copied verbatim, so the author's intent is not in doubt.
They are replaced by the values they would have produced on cloth
(`StuffPower_Armor_Sharp` 0.36, `_Heat` 0.18, `StuffPower_Insulation_Cold` and `_Heat` 18):

| Stat | Value |
|---|---|
| `ArmorRating_Sharp` | 0.072 |
| `ArmorRating_Heat` | 0.036 |
| `Insulation_Cold` | 1.8 |
| `Insulation_Heat` | 0.9 |

**Adding `stuffCategories` instead would have been wrong.** Stuffed apparel is tinted by its
material, and these eleven textures are painted artwork — a red devil, a white-and-red clown. Made
from stuff, every one of them would come out the colour of the cloth it was sewn from. The author
avoided that; the port keeps the avoidance and fixes the consequence.

### Left untouched, and worth knowing

**The masks spawn on strangers all year round.** Every one has `generateCommonality` of 1 and the
four apparel tags `Neolithic`, `MedievalMilitary`, `IndustrialBasic` and `IndustrialMilitary`,
which is what lets raiders, visitors and new colonists turn up in a clown mask in the middle of
summer. That is the author's balancing, not a break in the port — left as it stands, and one line
away in `Mod/Defs/ThingDefs_Misc/Masks.xml` if you would rather craft them yourself.

**`MaxHitPoints` is 100, where vanilla hats sit at 80.** The author's figure, kept.

**The defNames are unchanged** (`HMM_Mask_Devil` and the rest). A save that already used Halloween
Monster Mash therefore keeps its masks. The other side of that coin: the two mods cannot be loaded
together without a duplicate-defName conflict. Since the original supports 1.2 only, and needs
three Vanilla Expanded mods this one does not, that is not a combination anyone has reason to
want.

## What the port changed — the decorations

| Point | Decision |
|---|---|
| Nine near-identical defs | Folded onto a local `HMM_PropBase`. Each prop now declares only its name, label, description and graphic. Every value is the author's. |
| Title-case labels (`Fake Spider`, `Haunted Tree`) | Lower-cased, as vanilla does throughout. |
| `Jackolantern` | Spelled `jack-o-lantern` in the label. The defName `HMM_Jackolantern` is unchanged. |
| Two descriptions ending without a full stop | Fixed. |

Nothing here was broken by 1.6. These defs are valid as the author wrote them — `BuildingBase`,
the `Misc` designation category, `isInert`, scalar `drawSize`, all still current in 1.6.4871. They
failed for one reason only: the folder they lived in.

**Left as the author wrote it, including where it looks like an oversight.** The ghosts, the bats
and the skeleton suppress their drop shadow with `<shadowData><volume>(0,0,0)</volume></shadowData>`;
the spider, the tree, the reaper and the unlit pumpkin keep theirs. There is no pattern to it, and
it is tempting to normalise — but it is a visual choice, not a 1.6 fault, and not the port's to
settle.

## What the port changed — the sweets

| Point | Decision |
|---|---|
| Six near-identical defs | Folded onto a local `HMM_CandyBase`. Only `joy` and the graphic differ between them. |
| Six near-identical recipes | Folded onto an abstract `HMM_MakeCandyBase`. |
| `HMM_Make_BrainCakes` labelled `make Bloodshot Brain Cakes` | Fixed to `make brain cakes`. A copy-paste from the cake pops recipe directly above it in the source file. |
| Title-case labels | Lower-cased. |
| `A bunch sweet gummies`, `made with nugget` | Fixed to `a bunch of sweet gummies` and `nougat`. |
| Three dependencies for one used | See above: two dropped as unreferenced, Vanilla Cooking Expanded kept as a declared dependency. |

**The balance is untouched, and it is deliberately unremarkable**: these six are vanilla
`Chocolate` with a different sprite. Same 60 hit points, same market value of 3, same 0.075 mass,
same deterioration rate of 8, same 0.1 nutrition, same `DesperateOnly` preferability, same
`Gluttonous` joy kind, same `socialPropernessMatters`. Only the joy differs — 0.05 for candy corn,
0.25 for coffin bars, 0.15 for the rest — and that is the whole point of eating one rather than
another.

**Recipe costs changed after 1.0.0.** Nutrition-based counting was removed to address the suspected zero-nutrition sugar blocker. The original numbers now count items: 4 sugar plus 4 eggs, 4 chocolate, 25 fruit, 4 raw animal products (such as milk), 40 flour or 40 corn. Work remains 450 and output ten sweets. This changes ingredient balance; in-game validation is pending.

**No `tradeTags`.** No trader will ever carry these, and there is no other way to obtain them than
to cook them. That is the author's choice and it is coherent — a seasonal thing you make, not a
commodity. It is worth knowing before changing anything about the recipes: they are the only way
these six items enter a colony at all.

### The candy texture paths look broken and are not

The six sweets use `Graphic_StackCount` with a `texPath` such as `Candy/BloodshotCakePops`, while
the files on disk are `Candy/BloodshotCakePops/BloodshotCakePops_a.png` and its `_b` and `_c`
siblings. That reads like a missing path segment, and "fixing" it would break all six.
`Graphic_StackCount` extends `Graphic_Collection`, whose `Init` calls
`ContentFinder<Texture2D>.GetAllInFolder(req.path)`: the path is a **folder**, and the game picks
the variants out of it. Vanilla `Chocolate` and `Silver` are laid out the same way. Left alone.
