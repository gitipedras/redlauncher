require 'colorize'
require 'open-uri'
require 'json'
require_relative 'plugins'
require_relative 'functions'

if File.exist?('options.txt')
  if ARGV.include?('--plugin')
    pluginManager()
  
  elsif ARGV.include?('--admin-cmds')
    adminCmd()
  
  elsif ARGV.include?('--eula')
    puts "Accepting minecraft EULA... (minecraft.net/eula)".colorize(:yellow)
  
    Dir.chdir("#{path}") do
      eulaFile = File.new("eula.txt", "w")
  
      eulaFile.puts("eula=true")
  
      eulaFile.close
  
      eulaAccepted = true
    end
  
  elsif ARGV.include?('--delete')
    sudormrfslash()
  
    puts 'Your server has been deleted'.colorize(:yellow)
  
    exit
  end

  puts 'Loading redserver from config...'.colorize(:yellow)
  # Read JSON data from options.txt
  options_data = File.read('options.txt')

  # Parse the JSON data
  options = JSON.parse(options_data)

  serverName = options['serverName']
  serverVersion = options['serverVersion']
  eulaAccepted = options['eulaAccepted']

  puts "Server Name: #{serverName}"
  puts "Server Version: #{serverVersion}"
  puts "Eula Accepted: #{eulaAccepted}"

  puts 'Starting server...'.colorize(:yellow)

  Dir.chdir("server/") do
    output = `java -jar launch.jar 2>&1`
    success = $?.success?

    if success
      # Command executed successfully
      puts "Command executed successfully"
    else
      # Command encountered an error
      puts "Command failed with error: #{output}"
      File.open("logs/error_log.txt", "w") { |file| file.puts(output) }
    end
  end

else

  if ARGV.include?('--auto')
    autoInstall()

  end

  puts "It seems that you have not set up redserver yet, let's go through the setup now!".colorize(:yellow)
  
  puts "Server type: Paper (you cannot choose)"
  printf "Server Name:"
  serverName = gets.chomp
  
  printf "Server Version:"
  serverVersion = gets.chomp
  
  printf "Accept Minecraft EULA? [y/n] (aka.ms/mc-eula)"
  eulaAccepted = gets.chomp

  auti = false
  createServer(serverName, serverVersion, eulaAccepted, auti)
end

