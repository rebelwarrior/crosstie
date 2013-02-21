Feature: List the ids of applications running in a crossover bottle
  As a busy CrossOver Advocate, I want to write CrossTies quickly.
  This requires obtaining the unique process id of each application running under CrossOver wine in Linux.
  All Scenarios have the following givens: On a Linux Computer with CrossOver installed unless specified.
  
  
Scenario: List Available Bottles with option '-l'
  Given Command-Line on a Linux Computer w/ CrossOver installed.
  When I invoke c4p w/ '-l' option.
  Then I should get a listing of available bottles. 
  
Scenario: Use a non-Linux computer
  Given I used the program in a non-Linux computer.
  When I run the script
  Then It should warn me. 
  
Scenario: Should create the proper wine command to list applications in given bottle
  Given The bottle name is valid bottle name.
  When I run the script with a valid bottle name.
  Then It should assemble the proper command 
  And List the app's id of that bottle. 
  
Scenario: It should Error out properly
  Given I give an invalid bottle name
  When I run the script
  Then It should error out gracefully

  