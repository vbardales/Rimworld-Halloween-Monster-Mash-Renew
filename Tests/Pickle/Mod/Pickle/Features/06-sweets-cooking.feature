# The scenario that matters most, because the mod's one functional defect so far lived here and no offline
# check could see it. All six recipes asked for their ingredients by NUTRITION, and Vanilla Cooking
# Expanded's sugar has Nutrition 0: the game's ingredient search subtracts count x nutrition from what it
# still needs, so the requirement never fell and the bill could never be filled. The port now counts items
# (scripts/Test-CandyRecipes.ps1 proves the XML says so); only a colonist standing at a stove proves the
# game fills the bill and hands back ten sweets. It is the real-game replay of the old TF-05 and TF-06.
#
# Each scenario spawns 4 sugar and more than enough of the partner ingredient: the fixture colony's other
# colonists eat raw milk, eggs and corn from the shared stockpile while the cook works (another suite ran dry
# on 12 milk, 2026-09-26). So the partner count is NOT asserted, only the product and the sugar, which
# nobody eats (NeverForNutrition) and which must therefore be entirely consumed: four items, the amount that
# a nutrition count of zero could never have taken.
#
# UNVERIFIED and load-bearing: the stove is built finished with no fuel and the scenario relies on a
# colonist of the fixture refuelling it from the wood spawned in the stockpile. If no colonist does, the bill
# never starts and the wait ends the run; the fuel would then need a local step (FlavorTextExtendedFR has
# one, "a fuelled stove stands at"). The first run tells.
@slow
Feature: a colonist cooks the sweets from item counts

  Background:
    Given the save "test-colony" is loaded
    And a colonist "Cook" exists
    And "Cook" skill "Cooking" is set to level 10
    Then "Cook" can do "Cooking"
    And a "FueledStove" is built at (146, 155)
    And 30 "WoodLog" is spawned at the stockpile
    And 4 "VCE_RawSugar" is spawned at the stockpile
    When I set "Cook" priority "Cooking" to 1

  @timeout:300
  Scenario Outline: <recipe> makes ten sweets and takes all four sugar
    Given <amount> "<partner>" is spawned at the stockpile
    When I add bill "<recipe>" to the "FueledStove" at (146, 155)
    And game speed is ultrafast
    And I wait for bill "<recipe>" to finish
    Then 10 "<product>" exist
    And no "VCE_RawSugar" exists
    And no errors were logged

    Examples:
      | recipe                     | product               | partner                | amount |
      | HMM_Make_BloodshotCakePops | HMM_BloodshotCakePops | EggChickenUnfertilized | 12     |
      | HMM_Make_CoffinBars        | HMM_CoffinBars        | Chocolate              | 12     |
      | HMM_Make_BrainCakes        | HMM_BrainCakes        | Milk                   | 24     |
      | HMM_Make_MurderBuns        | HMM_MurderBuns        | VCE_Flour              | 60     |
      | HMM_Make_CandyCorn         | HMM_CandyCorn         | RawCorn                | 60     |

  # The sixth recipe wants the VCE_Fruit category, which Vanilla Plants Expanded defines. In a pass without
  # it the category does not exist and the recipe cannot be filled: that is the defect, seen by 01-load, not
  # a scenario that should be red. So it runs only where the category is, and a skip elsewhere is not a pass.
  @requires:VanillaExpanded.VPlantsE @timeout:300
  Scenario: spider bites make ten sweets from twenty-five fruit and four sugar
    Given 40 "VCE_RawApple" is spawned at the stockpile
    When I add bill "HMM_Make_SpiderBites" to the "FueledStove" at (146, 155)
    And game speed is ultrafast
    And I wait for bill "HMM_Make_SpiderBites" to finish
    Then 10 "HMM_SpiderBites" exist
    And no "VCE_RawSugar" exists
    And no errors were logged

  Scenario: an electric stove offers the sweet recipes too
    Given a "ElectricStove" is built at (150, 155)
    When I add bill "HMM_Make_CoffinBars" to the "ElectricStove" at (150, 155)
    Then the "ElectricStove" has 1 bills
    And no errors were logged
