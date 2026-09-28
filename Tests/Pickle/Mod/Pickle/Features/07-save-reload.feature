# Something the mod adds to a save, then a save and a reload: a worn mask, a built prop, a stack of sweets.
# `the save round trips` fails on any error logged during the trip, and the checks after it read the
# reloaded copy. Adding items and buildings from an XML-only mod cannot break ExposeData, so this is the
# cheap insurance that nothing here is missing from a save.
#
# NOT covered, and listed as open in TESTING.md: loading a copy of a 1.6 save made BEFORE these packaging
# changes and holding HMM items. No such save exists, and a test companion that depends on the mod cannot
# take it away to make one.
@slow @timeout:240
Feature: what the mod adds survives a save and a reload

  Scenario: a worn mask, a built prop and a stack of sweets come back
    Given the save "test-colony" is loaded
    And a colonist "Model" exists
    And I dress "Model" in "HMM_Mask_Skull"
    And a "HMM_Ghosts" is built at (146, 155)
    And I spawn a "HMM_CoffinBars" at (144, 155)
    When the save round trips
    Then "Model" is wearing "HMM_Mask_Skull"
    And a "HMM_Ghosts" is at (146, 155)
    And a "HMM_CoffinBars" exists
    And no errors were logged
