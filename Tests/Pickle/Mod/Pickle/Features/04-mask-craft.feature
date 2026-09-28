# The mask really is made, by a colonist, with no research. One full craft at the crafting spot, the
# workstation that needs nothing built around it; the two tailoring benches are asserted cheaply, by adding
# the bill (the step fails when the bench does not offer the recipe), because three benches times eleven
# masks would each cost a real craft for the same `recipeUsers` list.
#
# The fixture colony is not known to hold a colonist who can craft, so the first steps say it and a failure
# names its cause instead of timing out. A bill wait ends the game after 120 real seconds (seen by another
# suite on 2026-09-24); the launcher's default scenario timeout is 300 and this asks for the same.
@slow
Feature: a mask is made at a workstation

  @timeout:300
  Scenario: a colonist makes a devil mask at a crafting spot
    Given the save "test-colony" is loaded
    And a colonist "Tailor" exists
    Then "Tailor" can do "Crafting"
    When I set "Tailor" priority "Crafting" to 1
    And a "CraftingSpot" is built at (146, 155)
    And 30 "Cloth" is spawned at the stockpile
    And I add bill "Make_HMM_Mask_Devil" to the "CraftingSpot"
    And game speed is ultrafast
    And I wait for bill "Make_HMM_Mask_Devil" to finish
    Then a "HMM_Mask_Devil" exists
    And no errors were logged

  Scenario: a hand tailoring bench offers the mask
    Given the save "test-colony" is loaded
    And a "HandTailoringBench" is built at (146, 155)
    When I add bill "Make_HMM_Mask_Cat" to the "HandTailoringBench" at (146, 155)
    Then the "HandTailoringBench" has 1 bills
    And no errors were logged

  Scenario: an electric tailoring bench offers the mask
    Given the save "test-colony" is loaded
    And a "ElectricTailoringBench" is built at (146, 155)
    When I add bill "Make_HMM_Mask_Pirate" to the "ElectricTailoringBench" at (146, 155)
    Then the "ElectricTailoringBench" has 1 bills
    And no errors were logged
