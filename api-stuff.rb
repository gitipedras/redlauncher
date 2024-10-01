require 'net/http'
require 'json'
require 'open-uri'

def get_player_profile(player_name)
  url = "https://api.mojang.com/users/profiles/minecraft/#{player_name}"
  uri = URI(url)

  response = Net::HTTP.get(uri)
  player_data = JSON.parse(response)

  # Process the player data as needed
  if player_data.key?('id') && player_data.key?('name')
    puts "Player UUID: #{player_data['id']}"
    puts "Player Name: #{player_data['name']}"
  else
    puts "Player not found."
  end
rescue JSON::ParserError => e
  puts "Error parsing JSON: #{e.message}"
rescue StandardError => e
  puts "Error: #{e.message}"
end


def getServerDownload(path, version)
  url = "https://jar.setup.md/download/vanilla/#{version}/latest"
  uri = URI.parse(url)
  
  # Append the file name to the directory path
  file_name = "launch.jar"
  file_path = File.join(path, file_name)
  
  puts 'Downloading server jar file...'.colorize(:yellow)
  File.open(file_path, 'wb') do |local_file|
    local_file.write URI.open(uri).read
  end

  puts "Accepting minecraft EULA... (minecraft.net/eula)".colorize(:yellow)

  Dir.chdir("#{path}") do
  	eulaFile = File.new("eula.txt", "w")

	eulaFile.puts("eula=true")

	eulaFile.close

  end
end