# What the game reads for each sweet's recreation value. The six sweets are `HMM_CandyBase`, itself a
# copy of vanilla chocolate, plus a per-def <ingestible><joy>; the game merges the child's node into the
# parent's, and a mistake in that merge would leave a sweet at zero joy with no error anywhere. Only the
# joy differs between the six, and it is the only reason to eat one. Chocolate itself gives 0.10.
#
# No save is loaded: the def database is already built at the main menu. Whether the value is written
# "0.25" or "0.250" by the step is not established (nobody has played it); a red here that reads the right
# number in the wrong format is the step's, not the mod's.
Feature: each sweet is worth what its author set

  Scenario Outline: the game reads <joy> recreation for <sweet>
    Then def "<sweet>" field "ingestible.joy" is "<joy>"

    Examples:
      | sweet                 | joy  |
      | HMM_BloodshotCakePops | 0.15 |
      | HMM_CoffinBars        | 0.25 |
      | HMM_SpiderBites       | 0.15 |
      | HMM_BrainCakes        | 0.15 |
      | HMM_MurderBuns        | 0.15 |
      | HMM_CandyCorn         | 0.05 |
