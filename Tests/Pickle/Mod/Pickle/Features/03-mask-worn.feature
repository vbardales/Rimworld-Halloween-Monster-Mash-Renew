# A mask worn and drawn. The assertions say the colonist wears it and that it covers the upper head; the
# capture is what a person opens to see that it is drawn at all (a missing texture is a pink square, and the
# game logs it only when that facing is first drawn). @review: a green here says the trip ran, not that the
# picture is right.
#
# One facing is on screen, the one the colonist happens to have. The other two drawn facings, and the fourth
# the game mirrors, are a file contract: `Masks/<Name>/<Name>_north|east|south.png` exist for all eleven
# (44 files, checked offline). No Pickle step turns a pawn, so the four-facing check the manual campaign
# asked for is not automated; TESTING.md says so.
@review @slow @timeout:240
Feature: a colonist wears a mask and it is drawn

  Scenario Outline: the colonist wears the <mask>
    Given the save "test-colony" is loaded
    And a colonist "Model" exists
    When I dress "Model" in "<mask>"
    Then "Model" is wearing "<mask>"
    And "Model" apparel covers "UpperHead"
    When I close all dialogs
    And I zoom all the way in
    And I move the camera to "Model"
    And I take a screenshot "<mask> worn"
    Then no errors were logged

    Examples:
      | mask                 |
      | HMM_Mask_Devil       |
      | HMM_Mask_Clown       |
      | HMM_Mask_Witch       |
      | HMM_Mask_Frankenstein |
      | HMM_Mask_Mummy       |
      | HMM_Mask_Wolfman     |
      | HMM_Mask_Hockey      |
      | HMM_Mask_Skull       |
      | HMM_Mask_Zombie      |
      | HMM_Mask_Cat         |
      | HMM_Mask_Pirate      |
