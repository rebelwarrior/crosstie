#!/usr/bin/env ruby
require 'optparse'
test = true  #for testing only


def bottle_array(userpath)
  bottles = Dir.glob("#{userpath}/.cxoffice/*").select { |i| File.directory?(i) }
  Dir.glob("#{userpath}/.cxgames/*").select { |i| File.directory?(i) }.each do
    bottles << i
  end
  bottles = bottles.map { |i| i.split('/').last }.reject do |i| 
    i["tie"] or i["installers"] or i["desktopdata"] 
  end
  bottles
end

userpath = File.expand_path("~") #allows me to get user path.
bottles = bottle_array(userpath)
cx = "cxoffice"
bottle_name = nil #THIS HAS TO BE THERE! why? closure.

option_parser = OptionParser.new do |opts|
  opts.banner = '#=> Example Usage: c4p.rb -b "Bottle Name"'
  opts.on("-h", "--help", "Display this menu") { puts opts; exit }

  opts.on("-b BOTTLE", "--bottle", bottles, 
     "Assign a bottle to use from: \n\t\t#{bottles.join("\n\t\t")}") do |b| 
   bottle_name = b
  end

  opts.on("-g", "--games", "Use CrossOver Games: old versions only") do
    if File.directory?("#{userpath}/.cxgames") 
      cx = "cxgames"
    else 
      abort("Can't find Cross Over Games user Directory.") unless test
    end
  end
end
begin
  option_parser.parse!
rescue OptionParser::InvalidArgument => e
  puts e
  puts "Usage: c4p.rb -b 'Bottle Name'\nAvailable bottles: #{bottles.join(", ")}"
  exit(1)
end

puts "#####################"
puts ARGV #option parse removes the arguments used from the the list.
if ARGV && bottle_name.nil? && bottles.include?(ARGV[0])
  bottle_name = ARGV[0] #if bottles.include?(ARGV[0])
elsif ARGV[0] && bottle_name.nil?
  puts "#{ARGV[0]} Bottle not Found."
  puts "Available bottles: #{bottles.join(", ")}"
  exit
end  
puts "#=> Using #{bottle_name} bottle"
puts "#####################"
# 
# 

abort("Bottle name can't be blank") if bottle_name.nil?

#Check if bottle_name exists
#unless FileTest.directory?("#{userpath}/.#{cx}/#{bottle_name}") 
#  puts "ERROR: Directory #{bottle_name} doesn't exist."
#  exit
#end

#/opt/ or other directory for cx office/games

if FileTest.directory?("/opt/#{cx}")
  cxpath = "/opt/#{cx}" 
elsif FileTest.directory?("#{userpath}/.#{cx}/bin/") 
  cxpath = "#{userpath}/.#{cx}"
else 
  abort("Can't find your cx wine directory.") unless test #remove unless after test
end


#change %Q for %x for real use. Testing at the moment.
puts %Q`#{cxpath}/bin/wine --bottle "#{bottle_name}" ~/.#{cx}/#{bottle_name}/drive_c/windows/system32/uninstaller.exe --list`

#Goal: 
# "(path to cxoffice directory) /opt/bin/wine --bottle "(bottle name)" 
#  ~/.cxoffice/(bottle name)/drive_c/windows/system32/uninstaller.exe --list"

__END__
#Add the following directories to ~/.cxoffice/
=begin
["Spotify", "DAZ", "SumatraPDF", "Notepad++", "DragonStandard10", "Opera_1210", "Ephemeris", "SteamBloodlines", "7-Zip", "Quicken 2012"]
=end
