Feature: List the ids of applications running in a crossover bottle
  As a busy CrossOver Advocate, I want to write CrossTies quickly.
  This requires obtaining the unique process id of each application running under CrossOver wine in Linux.
  All Scenarios have the following givens: On a Linux Computer with CrossOver installed. 
  
  
Scenario: List Available Bottles with option '-l'
  Given Command-Line on a Linux Computer w/ CrossOver installed.
  When I invoke c4p w/ '-l' option.
  Then I should get a listing of available bottles. 