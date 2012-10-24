#!/usr/bin/env ruby

userpath = File.expand_path("~") #allows me to get user path.

#Resolving Arguments
if ARGV[0].nil? 
  then puts "You must at least supply a Bottle Name (in quotes) as an argument." ; return
end

ARGV[1].nil? ? bottle_name = ARGV[0] : bottle_name = ARGV[1]

#Allows for this input -o Quicken 2011 without quotes.
unless ARGV[2].nil?
  bottle_name = bottle_name + " " + ARGV[2]
  puts bottle_name
end

#Figures out if you have only one cx and defaults to it otherwise uses flags
if ( FileTest.directory?("#{userpath}/.cxoffice") and FileTest.directory?("#{userpath}/.cxgames") )
then
  case ARGV[0].to_s
    when "-cxg"
      cx = "cxgames" 
    when "-cx"
      cx = "cxoffice"
    when "-g"
      cx = "cxgames"
    when "-o"
      cx = "cxoffice"
    else 
      puts "Assuming you meant Cross Over (Office)." 
      cx = "cxoffice"
  end
elsif FileTest.directory?("#{userpath}/.cxoffice")
  cx = "cxoffice"
  puts "Assuming cxoffice."
elsif FileTest.directory?("#{userpath}/.cxgames") 
  cx = "cxgames"
  puts "Assuming cxgames."
else
  puts "Do you have CrossOver installed?"
  return
end

#Check if bottle_name exists
unless FileTest.directory?("#{userpath}/.#{cx}/#{bottle_name}") 
  puts "ERROR: Directory #{bottle_name} doesn't exist."
  puts "If your bottle name has spaces you must use quotes or add a -cx or -cxg flag."
  return
end

#/opt/ or other directory for cx office/games
if FileTest.directory?("/opt/#{cx}")
  cxpath = "/opt/#{cx}" 
elsif FileTest.directory?("#{userpath}/.#{cx}/bin/") 
  cxpath = "#{userpath}/.#{cx}"
else 
  puts "Can't find your cx wine directory."
  return
end

puts `#{cxpath}/bin/wine --bottle "#{bottle_name}" ~/.#{cx}/#{bottle_name}/drive_c/windows/system32/uninstaller.exe --list`



#Goal: 
# "(path to cxoffice directory) /opt/bin/wine --bottle "(bottle name)" 
#  ~/.cxoffice/(bottle name)/drive_c/windows/system32/uninstaller.exe --list"


