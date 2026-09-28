# Seven props built and drawn. Nothing about them is behaviour (Beauty 1, five wood, no comp of any kind), so
# what a running game adds is the picture and that placing one logs nothing. @review: the capture is what a
# person opens. The shadow differences between the ghosts, bats and skeleton (none) and the spider, tree,
# reaper and pumpkin (a shadow) are the author's own and are not a fault.
#
# Not asserted here, with the reason: that a colonist can cross one. `passability` is PassThroughOnly, a def
# field read by the game's own pathing; the mod answers for the field, and the field is a fact of the XML.
@review @slow @timeout:240
Feature: the decorations are built and drawn

  Scenario Outline: the <decoration> stands and is drawn
    Given the save "test-colony" is loaded
    When a "<decoration>" is built at (146, 155)
    And I close all dialogs
    And I zoom all the way in
    And I move the camera to (146, 155)
    And I take a screenshot "<decoration> built"
    Then a "<decoration>" is at (146, 155)
    And no errors were logged

    Examples:
      | decoration      |
      | HMM_Spider      |
      | HMM_Ghosts      |
      | HMM_Bats        |
      | HMM_Skeleton    |
      | HMM_Reaper      |
      | HMM_Tree        |
      | HMM_Jackolantern |
