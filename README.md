![image](http://www.codeweavers.com/images/themes/cw6/cw_logo_top.png)

Code Weavers' CrossOver Linux and CrossOver Mac can use a CrossTie or [c4p](http://www.codeweavers.com/support/wiki/c4p_user) recipe for installing windows programs. 

**CrossOver Advocates** can write these c4p recipes (now called CrossTies) but require running command to find information about the target application in the bottle. 

This scripts automatically runs the command to gain the ids of the applications within the bottle when supplied with a bottle's name in quotes for **Linux** installations. For Macs, from the terminal that opens form the 'Open Shell' option in the 'Run Command...' menu option, you can run: `wine windows/system32/uninstaller.exe --list`.

The script tries to determine where crossover's wine is located (in Linux) and which version of crossover do you have (Games or Office). It defaults to the Office (i.e. the non-games) version, which has recently become the *only* version with the release of **Crossover XI**. This script will still work for the older versions.

The new re-factored file, looks for all available bottles in your `~/.cxoffice` directory, and creates a list of bottles to validate against. Using the `-b` flag you can auto-complete bottle names. The old usage is retained in the re-factored file as well. 

**Usage:**

    $ruby c4p.rb "BottleName"

Where BottleName is the name of the bottle where the program is installed.

You can do: `$ruby c4p.rb -h` for help on the new file. 
	

**RE-FACTORED** to use option parse. Old file left for comparison purposes.

**TO DO**

1. Add Aruba tests.

- Have it detect Macs automatically and prompt w/ proper command w/o running script. (Changed to just a passive warning if not using Linux.)