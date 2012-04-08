![image](http://www.codeweavers.com/images/ranks/swag_sticker_K_256.png)

Code Weavers' CrossOver Linux and CrossOver Mac can use a crosstie or [c4p](http://www.codeweavers.com/support/wiki/c4p_user) recipie for installing windows programs. 

**CrossOver Advocates** can write these c4p recipies but require running command to find information about the target application in the bottle. 

This scripts automatically runs the command to gain the ids of the applications within the bottle when supplied with a bottle's name in quotes for **Linux** installations.

The script tries to determine where crossover's wine is located (in Linux) and which version of crossover do you have (Games or Office). It defaults to the Office (i.e. the non-games) version, which has recently become the *only* version with the release of **Crossover XI**. This script will still work for the older versions.


**Usage:**

    $ruby c4p.rb "BottleName"

Where BottleName is the name of the bottle where the program is installed.