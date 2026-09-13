# Halloween Monster Mash Renew: what to check in game

## Automated checks

From the repository root, using PowerShell 7:

```powershell
pwsh -NoProfile -File ../scripts/Check-XmlFields.ps1 -ModPath ./Mod
pwsh -NoProfile -File ./scripts/Test-CandyRecipes.ps1
```

The first command uses the shared utility in the parent `rimworld/scripts` directory and
installed RimWorld assemblies (override their path with `-Managed`). It is not included
in this repository. The second is standalone and accepts `-ModPath` for another copy.
It checks all six recipes, item counting, ingredients and their filters, quantities,
products, work and both stoves. Failure returns a nonzero exit code.

Results from 2026-09-12: 5 files with no unknown RimWorld 1.6 XML fields; all six recipes
passed. A temporary copy with nutrition counting restored was rejected as expected.
These checks do not replace an in-game run.

## Functional test campaign

Run the scenarios below manually on RimWorld 1.6. **No in-game results have been established.**
The static checks and historical diagnosis below do not replace this campaign. In particular,
the sugar blockage described in historical scenario 5 is a documented hypothesis that was
not reproduced while these scenarios were written.

### Preparation

- Use a test colony and a copy of any existing save.
- Load Core, Vanilla Cooking Expanded and its dependencies (including Harmony and Vanilla
  Expanded Framework), then this mod, respecting their required load order. Disable the
  original mod. Install the `Mod/` directory, not the repository root.
- Enable developer mode to prepare stocks and inspect the log. Disable instant construction
  when measuring consumption and work.
- Prepare an available adult capable of construction, crafting and cooking; enable these
  jobs. Make ingredients reachable, allowed and within the bills' ingredient radius.
- Record exact game/mod versions, language, DLC and load order.
- For each case, record `Not run`, `Passed`, `Failed` or `Blocked`, the observed result,
  and a screenshot or `Player.log` excerpt for any discrepancy.

### TF-01 — Loading and dependency

**Preconditions:** the base configuration above, without DLC or Props as Style.

1. Open the mod list and check the name, icon, banner and VCE dependency.
2. Restart with this configuration and create the test colony.
3. Inspect the log, crafting menus and Misc tab.
4. In a separate configuration, disable VCE and check the dependency warning in the mod list;
   restore the base configuration before playing.

**Expected:** no loading error attributable to HMM; eleven masks, seven decorations and six
recipes available at the corresponding workstations. Missing VCE is reported; running without
it is not a supported game configuration.

### TF-02 — Crafting eleven masks at three workstations

**Preconditions:** no research; crafting spot, hand tailoring bench and powered electric
tailoring bench; at least 990 cloth for all 33 crafts.

1. At each workstation, check all eleven bills: devil, clown, witch, Frankenstein, mummy,
   wolfman, hockey, skull, zombie, cat and pirate.
2. Add a "do once" bill for each mask and let the colonist work.
3. Compare stocks before/after each craft and inspect the item's information card.

**Expected:** one item of the requested model per bill, 30 cloth consumed, no material choice
or additional research. Nominal work is 1400, not a fixed duration in seconds; colonist and
workstation speeds affect duration. No missing graphics.

### TF-03 — Wearing, orientations and protection

**Preconditions:** eleven new masks at 100% durability, an adult with no other headgear.

1. Force-wear each mask, then move the colonist north, east, south and west to observe all
   four orientations; adjust headgear visibility as needed.
2. Open each mask's information card and record the four protection stats.
3. Equip a vanilla hat occupying `Overhead` and `UpperHead`, then equip the mask again.
4. With Biotech active and a child available, repeat wearing all eleven masks.

**Expected:** correct rendering in all orientations; incompatible headgear is replaced.
For each new mask: sharp armor 7.2%, heat armor 3.6%, cold insulation 1.8 °C and heat
insulation 0.9 °C. Adults and children can wear them. Without Biotech, record the child
subcase as not run and explain why.

### TF-04 — Building and behavior of seven decorations

**Preconditions:** no research, 35 wood available, a builder and buildable ground.

1. Under Architect → Misc, place the spider, ghosts, bats, skeleton, reaper, tree and unlit pumpkin.
2. Let each object be built, then record costs and stats.
3. Have a colonist cross a passage whose only traversable tile contains a decoration.
4. Observe the objects at night and check that they have no fuel or power controls.

**Expected:** seven distinct objects, 5 wood each, nominal work 50, beauty 1, 40 hit points
and a one-cell footprint. Traversal is possible; do not require unchanged movement speed.
The objects are inert props; the pumpkin produces no light. Artwork may extend beyond the
footprint. The shadow differences described below are not failures.

### TF-05 — Cooking six sweets and validating item counting

**Preconditions:** a powered electric stove, then a fueled wood stove; an available cook;
VCE sugar and partner ingredients in the item quantities below. Also check bill filters
and ingredient radius.

| Recipe / product | Allowed partner | Partner items consumed | Sugar items consumed | Output |
| --- | --- | ---: | ---: | ---: |
| `HMM_Make_BloodshotCakePops` / `HMM_BloodshotCakePops` | Unfertilized eggs | 4 | 4 | 10 |
| `HMM_Make_CoffinBars` / `HMM_CoffinBars` | Chocolate | 4 | 4 | 10 |
| `HMM_Make_SpiderBites` / `HMM_SpiderBites` | `VCE_Fruit` category | 25 | 4 | 10 |
| `HMM_Make_BrainCakes` / `HMM_BrainCakes` | `AnimalProductRaw` category; use milk | 4 | 4 | 10 |
| `HMM_Make_MurderBuns` / `HMM_MurderBuns` | VCE flour | 40 | 4 | 10 |
| `HMM_Make_CandyCorn` / `HMM_CandyCorn` | Raw corn | 40 | 4 | 10 |

These values now count items regardless of nutrition. Prepare exactly the listed quantities
for each batch and check that all of them are consumed.

1. At each stove, add one "do once" bill for each recipe, proceeding one recipe at a time
   so consumption can be identified clearly.
2. Check that sugar and the partner ingredient are enabled in the bill filters.
3. Ask the colonist to cook, observe whether the job starts and retain log messages.
4. If the bill completes, record consumed ingredients and count the resulting product.

**Functional expectation:** every bill starts and produces ten units of the correct product,
with nominal work 450. No invalid-quantity warning.

**Fix validation:** each batch must consume exactly the listed quantities, including 4 sugar
even if sugar has zero nutrition. Record VCE version, sugar nutrition and actual consumption.
A blocked bill under correct conditions, different consumption or an invalid-quantity warning
is a failure.

### TF-06 — Missing/excluded ingredients and resumption

**Preconditions:** the same workstations and bills as TF-02 and TF-05.

1. For a mask, leave only 29 cloth accessible; request crafting.
2. Add the thirtieth cloth and request crafting again.
3. For each sweet, remove sugar, then remove only the partner ingredient.
4. Restore the stocks, exclude sugar in the bill filter, then allow it again.

**Expected:** no crafting or partial consumption when required ingredients are missing or
excluded. The mask becomes craftable with 30 cloth. Sweet production should resume when
everything is available; if TF-05 fails because of sugar, record this last check as blocked
by the same defect, not passed.

### TF-07 — Sweet graphics, stacking and consumption

**Preconditions:** spawn products in developer mode to keep this case independent of TF-05;
an adult able to eat, with unsaturated food and recreation needs.

1. For each of the six products, create stacks of 1, 25 and 75 and observe their sprites.
2. Have two stacks of the same product hauled and merged without exceeding 75 per stack.
3. Inspect the information card: nutrition 0.1 and product-specific recreation.
4. From comparable initial conditions, ask the colonist to consume each product; record
   stock reduction and need changes. Reset needs between trials.

**Expected:** valid textures at all three stack sizes; stacking and hauling work; products
can be consumed and increase needs. Defined joy values: 0.25 for coffin bars, 0.05 for candy
corn and 0.15 for the other four. Do not require the recreation need to rise by exactly
these amounts: saturation and tolerance can affect it.

### TF-08 — French translation and return to English

**Preconditions:** the objects and bills from the previous cases are available.

1. Switch to French and restart if requested by the game.
2. Check names and descriptions for eleven masks, seven decorations and six sweets.
3. Check names, descriptions and work text for six recipes; if cooking is blocked, record
   any work text that could not be observed separately.
4. Switch back to English and check the same menus and information cards.

**Expected:** complete French text, correct accents, no raw keys or mixed-language fallback
in translated fields; English text returns after switching languages. Check clipping and
formatting in both languages and retain any relevant log messages.

### TF-09 — Saving and reloading

**Preconditions:** a colonist wearing a mask, seven built decorations, six spawned sweets
and crafting bills. Keep the same mods and versions.

1. Record models, positions, quantities and durability, then save.
2. Quit, restart the game and load that save.
3. Compare objects, equipment and bills; resume hauling and crafting.

**Expected:** no missing or replaced objects, preserved data and working actions, with no
new HMM error. Track any confirmed cooking defect separately. This subcase does not prove
migration from an old 1.2 save.

**Existing-save subcase:** use a copy of a RimWorld 1.6 save made before these packaging
changes, with HMM items/bills if available. Record its exact source mod revision and load order.
Load the copy with this revision, compare the existing items/bills to the recorded baseline,
craft a mask and a sweet, save to a new slot, restart and reload. Expect existing HMM data to
survive and new content to work without HMM load/save errors. Never overwrite the source save.
If no suitable save exists, record this subcase as unverified. Cross-version migration from
1.2 is a separate claim and must not be inferred from this test.

### TF-10 — Optional Props as Style integration

**Preconditions:** a separate configuration with Props as Style and the dependencies/DLC
required by its installed version. Record their versions. This case does not condition the
base test without DLC.

1. Check that the Halloween style group is offered.
2. Apply the four styles listed in historical scenario 7 to their corresponding vanilla buildings.
3. Build the small sculpture, torch lamp, campfire and brazier using these styles.
4. Compare their functions with the same buildings without styles: fuel, light, heat and
   cooking wherever the vanilla building offers that function.
5. Save and reload, then check all four appearances.

**Expected:** gargoyle, lit pumpkin, cauldron and candle render correctly; vanilla building
behavior is preserved. The unlit HMM pumpkin remains a separate object. These four styles do
not become four additional HMM constructions. If the integration is not installed, record
this case as not run and explain why.

### Results sheet

| Case | Initial status | Observation / evidence |
| --- | --- | --- |
| TF-01 | Not run | |
| TF-02 | Not run | Detail all 11 models × 3 workstations |
| TF-03 | Not run | Detail orientations, stats and child subcase |
| TF-04 | Not run | Detail all 7 decorations |
| TF-05 | Not run | Detail all 6 recipes × 2 stoves |
| TF-06 | Not run | |
| TF-07 | Not run | Detail all 6 products |
| TF-08 | Not run | |
| TF-09 | Not run | Record new-colony reload and existing-save subcases separately |
| TF-10 | Not run | Optional configuration |

Acceptance requires passing the applicable TF-01–TF-09 cases. A confirmed TF-05 blockage
is a cooking defect even if developer-spawned products pass TF-07. Keep the log and a
reproduction save for each anomaly. Document justified exclusions for optional cases.

---

## Historical technical notes from the initial draft

The following notes are retained as historical context. Their predictions and references
to earlier checks were not reverified while translating this document. The active campaign
above takes precedence. In particular, the old "no Harmony" claim below is superseded:
VCE requires Harmony and Vanilla Expanded Framework transitively.

Five static checks pass on this mod, run on 2026-09-12:

| checker | result |
|---|---|
| `Check-DefRefs` | 30 defs, 4 parents, every reference resolves |
| `Check-XmlFields` | 5 files, every element maps to a 1.6 field |
| `Check-ConfigErrors` | 34 defs, 26 rules, no config error |
| `Check-DefInjected` | 66 French keys, none dead |
| textures | 73 files, every `texPath` has something behind it |

None of them can load the game, and none of them looks at whether a recipe can ever be filled.
Historical scenario 5 describes the suspected failure before the item-count correction.
Use TF-05 and TF-06 above to validate the corrected recipes in game.

The mod has never run. Junction `HalloweenMonsterMashRenew/Mod` into `RimWorld/Mods` — the `Mod`
folder, not the repository root; the junction already exists. Play with dev mode on and keep the
log:

```
C:\Users\nelim\AppData\LocalLow\Ludeon Studios\RimWorld by Ludeon Studios\Player.log
```

---

## 1. It loads

Enable Core, Vanilla Cooking Expanded and this mod. No DLC and no Harmony are needed. Vanilla
Cooking Expanded is a hard dependency: without it the six recipes name defs that do not exist, and
a `RecipeDef` whose ingredient filter names a missing thing does not degrade quietly, it throws and
takes its file with it.

**Expect:** `Halloween Monster Mash Renew` in the list, its icon beside it, its banner on the mod
page. No red text at startup.

**Fails if:** any `XML error`, `Could not resolve cross-reference` or `Could not find type` naming
`HMM_`. A def that fails to load is silently absent afterwards, so a clean start is what every
scenario below rests on.

## 2. The eleven masks are made and worn

Build a crafting spot. All eleven bills should be there with no research done at all — the mod
overrides `recipeUsers` to add `CraftingSpot` to the two tailoring benches, and neither
`ApparelMakeableBase` nor `HatMakeableBase` carries a research prerequisite.

Make one of each: 30 cloth, 1400 work. Put them on a pawn and rotate the camera.

**Expect:** the mask drawn over the upper head from all four facings. It competes with hats, not
with helmets, because it sits on the `Overhead` layer over `UpperHead`.

**Fails if:** a pink box appears at any facing. Each mask ships three textures, `_north`, `_east`
and `_south`, and the game mirrors east for west; a missing one shows as pink. Forty-four mask
textures in eleven folders.

**Also check:** put one on a child. `developmentalStageFilter` is `Child, Adult`, which vanilla
headgear carries and the 1.2 originals did not.

## 3. The masks protect, for the first time

This is the port's largest change and the only one a player can measure. The originals declared
`costStuffCount` and three `StuffEffectMultiplier` stats with no `stuffCategories` anywhere in the
ancestry, so `MadeFromStuff` was false and all four lines were inert: the protection eleven
descriptions promise was exactly zero. They are replaced by the flat values those multipliers
would have produced on cloth.

Select a mask → **Information** tab.

| stat | this mod | where the number comes from |
|---|---|---|
| Armor - Sharp | 0.072 | cloth 0.36 x 0.2, the multiplier every cloth hat in Core uses |
| Armor - Heat | 0.036 | cloth 0.18 x 0.2, same |
| Insulation - Cold | 1.8 | cloth 18 x 0.1, the cowboy hat, bowler hat and tribal headdress figure |
| Insulation - Heat | 0.9 | cloth 18 x 0.05, the war mask and war veil figure |

So a mask is a cloth cowboy hat for sharp damage and for cold, and a tenth of one for heat. For
scale, a cloth tuque insulates 9 degrees of cold, five times a mask; a cloth mask insulates 0.36,
a fifth of one. "Mediocre" is the right word.

**Fails if:** any of the four reads zero. That is the 1.2 behaviour and would mean the flat values
did not take.

**One thing the changelog says loosely.** It calls the multipliers "the vanilla hat block, copied".
Each of the three numbers is a vanilla hat's number, but no single vanilla hat in 1.6 combines
0.2 armour with 0.1 cold and 0.05 heat — the hats at 0.1 cold all give more heat, and the two that
give 0.05 heat give 0.05 cold. Nothing to fix in the defs; the sentence is what overstates.

## 4. The seven decorations build

Architect → **Misc**. Seven entries: fake spider, ghosts, bats, skeleton, reaper, haunted tree,
jack-o-lantern. Five wood each, 50 work, no research, no power, no material choice.

**Expect:** each one built and drawn, `Beauty 1` on its information card, pawns walking through it
rather than around it — `passability` is `PassThroughOnly` at 30 % fill.

**Fails if:** a pink box, or a missing entry. Eleven decoration textures ship; only seven have a
`ThingDef`, and that is scenario 7.

**Not a fault:** the ghosts, the bats and the skeleton cast no drop shadow while the spider, the
tree, the reaper and the jack-o-lantern do. That is the author's own inconsistency, carried
deliberately.

## 5. Historical diagnosis before the item-count correction

The following describes the earlier nutrition-based recipes, not the current XML. The failure was never reproduced in game. The chosen correction removes the getter and keeps the numbers as item counts. Validate current behavior with TF-05 and TF-06.

### Original predicted failure

**This is the scenario to run first, and it is expected to fail.** It was found by writing this
document rather than by playing, and the game's own code says why.

Build a stove, stock raw sugar and any of the six partner ingredients, and add a bill for any of
the six sweets.

**Predicted:** the bill is never started. A cook walks to the stove, finds the bill unfillable and
leaves. `Player.log` fills with a yellow warning at each attempt:

```
Tried to set ThingCount stack count to -2147483648. thing=Sugar...
```

**Why, read off `Assembly-CSharp.dll` rather than assumed.** All six recipes ask for their
ingredients by nutrition, not by item count — `IngredientValueGetter_Nutrition`, which the author
wrote and the port carried unchanged. That getter returns an ingredient's `Nutrition` stat, and
zero for anything that is not a nutrition-giving ingestible. **Vanilla Cooking Expanded's sugar has
`Nutrition` 0.** It is a condiment: it feeds nobody and it is `NeverForNutrition`.

Every recipe asks for 4 units of it. The search adds sugar to the basket, subtracts `count x value
per unit` from what it still needs, and the value per unit is zero, so the requirement never
falls. The negative number in the warning is the same zero seen from the other side: the code
divides what it still needs by the value per unit, four over zero is infinity, and casting that to
an integer lands on the bottom of the range.

Vanilla Cooking Expanded never uses its own sugar as a counted ingredient, so nothing upstream
ever exercised this.

**If it passes anyway**, the reading above is wrong and that matters more than the scenario: say
so, and keep the log.

**Alternatives considered before the correction.** Dropping the
`ingredientValueGetterClass` line makes every count an item count, and the author's numbers then
read as sane recipes: 4 eggs, 4 chocolate, 25 fruit, 4 milk, 40 flour, 40 corn, 4 sugar. Keeping
the getter and special-casing sugar preserves the author's intent but needs a number invented for
him. The first is a smaller edit and a larger change of balance.

**The second finding, which survives either fix.** Read as nutrition, the partner ingredients are
already far outside anything vanilla cooks:

| recipe | partner | asks for | that is | sugar |
|---|---|---|---|---|
| bloodshot cake pops | unfertilized eggs | 4 nutrition | 16 eggs | 4 |
| coffin bars | chocolate | 4 nutrition | 40 chocolate | 4 |
| brain cakes | raw animal product | 4 nutrition | 80 milk | 4 |
| spider bites | fruit | 25 nutrition | 500 berries | 4 |
| murder buns | flour | 40 nutrition | 800 flour | 4 |
| candy corn | raw corn | 40 nutrition | 800 corn | 4 |

A vanilla simple meal costs 0.5 nutrition and returns 0.9. A batch of candy corn would cost 44 and
return ten sweets worth 0.1 each, so 1.0 — eighty-eight simple meals of food for one tenth of one
meal back. Whatever is decided about the sugar line, these numbers deserve a sentence in the
changelog, because nothing else in the repository relates them to a vanilla recipe.

## 6. The sweets themselves

Spawn the six with dev mode, which sidesteps scenario 5 entirely, and have a pawn eat each.

**Expect:** chocolate with a different sprite. Same 60 hit points, market value 3, mass 0.075,
deterioration 8, nutrition 0.1, `DesperateOnly` preferability, `Gluttonous` joy, four eaten at a
time. Only the recreation differs, and it is the only reason to eat one.

| sweet | joy | against chocolate's 0.10 |
|---|---|---|
| coffin bars | 0.25 | two and a half times |
| cake pops, spider bites, brain cakes, murder buns | 0.15 | half again |
| candy corn | 0.05 | half |

**Fails if:** the item draws as a pink box. These use `Graphic_StackCount`, which reads a whole
folder rather than a file, so a mislaid folder gives `Collection cannot init: No textures found at
path` in the log and a bad graphic on screen. Three sprites each, at one, at a middling stack and
at a full stack of 75.

**Not a fault:** no trader will ever carry one. The sweets have no `tradeTags`, which is the
author's choice. The masks do trade — `ApparelMakeableBase` gives them the `Clothing` tag.

## 7. The four missing decorations, as styles

Enable Props as Style as well. It gates its Halloween folder on this mod's `packageId`, and its
four styles read textures out of this mod's `Textures` folder.

| style | dresses | texture, shipped here |
|---|---|---|
| `PAS_Halloween_SculptureSmall` | small sculpture | `Decorations/Gargoyle/Gargoyle` |
| `PAS_Halloween_TorchLamp` | torch lamp | `Decorations/JackolanternL/JackolanternL` |
| `PAS_Halloween_Campfire` | campfire | `Decorations/Cauldron/Cauldron` |
| `PAS_Halloween_Brazier` | brazier | `Decorations/Candle/Candle` |

**Expect:** the halloween style group offered, and each of the four vanilla buildings drawn in the
Halloween artwork while keeping its own behaviour — the torch lamp still refuels and lights, the
brazier still pushes heat.

**Fails if:** a pink box on any of the four. That is the coupling to check: the textures live here
and nowhere else, so deleting one of the four "unused" texture folders would break another mod
silently.

**Also check** that the lit jack-o-lantern and the unlit one are not confused. `HMM_Jackolantern`
is the dark building in scenario 4; the lit pumpkin has no `ThingDef` at all and exists only as
this style.

## 8. French

Switch the language to French and look at the same objects.

**Expect:** every label and description translated — eleven masks, seven decorations, six sweets,
six recipes. Sixty-six keys, all of them checked against the defs.

**Fails if:** a raw key appears in place of a label.

## 9. Not with the original

Do not enable `[KD] Halloween Monster Mash` at the same time. Every defName is unchanged, which is
what lets an old save keep its things, and is also what makes the two mods collide.

**Expect**, if both are on: the usual duplicate-defName behaviour, the last loaded winning in
silence. There is nothing to verify here; it is a thing not to do.

---

## What to send back

`Player.log` from the session, plus one line per scenario. Scenario 5 is the one whose answer is
not already known: whether the bill is refused, and whether the warning above is in the log.
