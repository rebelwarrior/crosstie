#!/usr/bin/env ruby
require 'optparse'

def bottle_array(userpath, exc_games=false)
  bottles = Dir.glob("#{userpath}/.cxoffice/*").select { |i| FileTest.directory?(i) }
  unless exc_games
    Dir.glob("#{userpath}/.cxgames/*").select { |i| FileTest.directory?(i) }.each do
      bottles << i
    end
  end
  bottles.map! { |i| i.split('/').last }.reject do |i| 
    i["tie"] or i["installers"] or i["desktopdata"] 
  end 
end

test = false #default to false unless testing  
userpath = File.expand_path("~") #allows me to get user path.
bottles = bottle_array(userpath)
cx = "cxoffice"
bottle_name = nil #THIS HAS TO BE THERE! why? closure.

#Command Line Options Set up.
option_parser = OptionParser.new ('banner can go here') do |opts|
  opts.banner = %Q`#=> Example Usage: #{File.basename($0)} -b "Bottle Name" ` 
  #moved it!
  opts.program_name = "CrossTie Install Pattern Finder:" #defaults to $0
  opts.version = "2.0"
  opts.on("-v", "--version", "Display version info") {puts opts.ver; exit }
  opts.on("-h", "--help", "Display this menu") { puts opts; exit } #optional Optparse generates
  opts.on("-t", "--test", "Doesn't execute only builds String") { test = true }
  opts.on("-l", "--list", "Lists Available Bottles") { puts "Bottles: #{bottles.join(", ")}"; exit}
  opts.on("-b BOTTLE", "--bottle", bottles, \
          "Assigns a bottle to use from: \n\t\t#{bottles.join("\n\t\t")}") {|b| bottle_name = b } 
  opts.on("-g", "--games", "Use CrossOver Games: old versions only") do 
    cx = "cxgames"
    raise OptionParser::InvalidOption, \
    "Can't find user .cxgames directory." unless FileTest.directory?("#{userpath}/.cxgames")
  end
end

begin
  option_parser.parse!
rescue OptionParser::InvalidArgument => e
  puts e
  puts "Usage: c4p.rb -b 'Bottle Name'\nAvailable bottles: #{bottles.join(", ")}"
  exit(1)
rescue OptionParser::MissingArgument => e
  puts e
  puts "You're missing a 'Bottle Name' argument.\nAvailable bottles: #{bottles.join(", ")}"
  exit(1)
rescue OptionParser::InvalidOption => e
  puts e
  exit(1) unless test
end

def process_argv(bottle_name, bottles, argv=ARGV)
  if bottle_name.nil? 
    if !argv.empty? && bottles.include?(argv[0])
      bottle_name = argv[0]
    elsif !argv.empty? && bottles.include?(argv.join(" "))
      bottle_name = argv.join(" ")
    elsif !argv.empty?
      puts "Can't find bottle name. \nAvailable bottles: #{bottles.join(", ")}"
      exit(1)
    else
      puts "Bottle Name can't be blank."
      # puts "Use '-h' for help.\nAvailable bottles: #{bottles.join(", ")}"
      puts option_parser.help
      exit(1)
    end
  end
  bottle_name
end

puts "#####################"
#option parse! removes the arguments used from the the arugments stream.
puts "Extra Argument(s): #{ARGV.join(", ")}" unless ARGV.empty?
bottle_name = process_argv(bottle_name, bottles)
puts "#=> Using #{bottle_name} bottle"
puts "#####################"
# 
# 

#abort("Bottle name can't be blank") if bottle_name.nil?

#/opt/ or other directory for cx office/games
if FileTest.directory?("/opt/#{cx}")
  cxpath = "/opt/#{cx}" 
elsif FileTest.directory?("#{userpath}/.#{cx}/bin/") 
  cxpath = "#{userpath}/.#{cx}"
else 
  abort("Can't find your cx wine directory.") unless test 
end


#change %Q for %x for real use. Testing at the moment.
if test 
  puts %Q`#{cxpath}/bin/wine --bottle "#{bottle_name}" ~/.#{cx}/#{bottle_name}/drive_c/windows/system32/uninstaller.exe --list`
else
  puts %x`#{cxpath}/bin/wine --bottle "#{bottle_name}" ~/.#{cx}/#{bottle_name}/drive_c/windows/system32/uninstaller.exe --list`
end
#Goal: 
# "(path to cxoffice directory) /opt/bin/wine --bottle "(bottle name)" 
#  ~/.cxoffice/(bottle name)/drive_c/windows/system32/uninstaller.exe --list"

__END__

