# The port's largest change, and the only one a player can measure. The 1.2 originals declared a stuff cost
# and three StuffEffectMultiplier stats with no stuffCategories anywhere in the ancestry, so every mask
# protected exactly nothing while eleven descriptions promised otherwise. The port writes the flat values
# those multipliers would have produced on cloth. `stat` reads what the game computes, not the XML: a zero
# here means the game did not take the values, which no offline check can say.
#
# No save is loaded, so this runs at the main menu with the def database already built (Pickle's
# def steps need none): eleven examples in a few seconds.
Feature: every mask protects, for the first time

  Scenario Outline: the game computes the flat protection of the mask
    Then def "<mask>" stat "ArmorRating_Sharp" is 0.072
    And def "<mask>" stat "ArmorRating_Heat" is 0.036
    And def "<mask>" stat "Insulation_Cold" is 1.8
    And def "<mask>" stat "Insulation_Heat" is 0.9

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
