# The four facings of a worn mask. 03 shows the one facing the colonist happens to have; here the colonist is
# placed on a cell and turned north, east, south and west in turn, so the three drawn textures
# (`Masks/<Name>/<Name>_north|east|south.png`) and the mirrored fourth are each put on screen once. One mask
# is enough per facing: all eleven share the same drawing code and the 44 files are checked offline; the mask
# with the most asymmetric artwork (the devil) is the one to look at. @review: a green says the trip ran, not
# that the picture is right.
#
# UNVERIFIED: that cell (146, 157) is free and walkable in the fixture colony, and that `facing` takes the
# words north, east, south and west. The first run tells; a red on either is the suite's, not the mask's.
@requires:nelim.pickletools.colonistrace
@review @slow @timeout:240
Feature: a worn mask is drawn from the four sides

  Scenario Outline: the devil mask seen facing <side>
    Given the save "test-colony" is loaded
    And a colonist "Model" exists
    When I dress "Model" in "HMM_Mask_Devil"
    And Nelim's Pickle Tools: "Model" stands at (146, 157) facing <side>
    Then "Model" is wearing "HMM_Mask_Devil"
    When I close all dialogs
    And I zoom all the way in
    And I move the camera to "Model"
    And I take a screenshot "HMM_Mask_Devil facing <side>"
    Then no errors were logged

    Examples:
      | side  |
      | north |
      | east  |
      | south |
      | west  |
