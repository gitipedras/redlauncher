require 'colorize'
require 'open-uri'

require_relative 'api-stuff'


player_name = 'GreatBigDiamond'

#get_player_profile(player_name)

puts 'Launching...'.colorize(:yellow)

reddir = 'red_files'
puts "Directory is #{reddir}".colorize(:yellow)


def getDownload(path, url)
  uri = URI.parse(url)
  File.open(path, 'wb') do |local_file|
    local_file.write URI.open(uri)
  end
end

def parse_json_and_return_values(json_string)
  data = JSON.parse(json_string)

  # Access and return specific values from the parsed JSON data
  value1 = data['key1']
  value2 = data['key2']['nested_key']
  
  return value1, value2
rescue JSON::ParserError => e
  puts "Error parsing JSON: #{e.message}"
end

json_string = File.read('red_files/options.txt')

def createNewInstance(instanceName, instanceVersion)
  instanceDir = "red_files/instances/#{instanceName}/"
  Dir.mkdir(instanceDir)

  case instanceVersion
  when "1.21"
    file_name = "client.jar"
    file_url = "https://piston-data.mojang.com/v1/objects/30c73b1c5da787909b2f73340419fdf13b9def88/#{file_name}"
    getDownload("#{instanceDir}/#{file_name}", file_url) # Pass the complete file path to getDownload
  end
end

def createServerInstance(instanceName, instanceVersion)
  instanceDir = "red_files/instances/#{instanceName}/"
  Dir.mkdir(instanceDir)
    
  getServerDownload(instanceDir,instanceVersion)
  
end


puts '[1] Create New Instance [2] Manage Instances [3] Exit [4] Launch Instance'
printf '>'
cm = gets.chomp

case cm 
when "1"
  printf 'Instance Name>'
  instanceName = gets.chomp

  printf 'Instance Version>'
  instanceVersion = gets.chomp

  printf 'Instance Type>'
  instanceType = gets.chomp

  case instanceType

    when 'client'
      puts "Client is not supported!"

    when 'server'
      createServerInstance(instanceName, instanceVersion)

  end

when "4"
  printf 'Instance Name>'
  instanceName = gets.chomp

  puts "Launching instance '#{instanceName}' at 'red_files/instances/#{instanceName}/launcher.jar"

  Dir.chdir("red_files/instances/#{instanceName}/") do
  
    if system("java -jar launch.jar")
      puts "Server Exited".colorize(:yellow)
    else
      puts "Command failed with exit status: #{$?.exitstatus}"
      puts "Is the jar file called launcher.jar? Check log for more info.".colorize(:red)
    end
  end

end