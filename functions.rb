require 'colorize'
require 'open-uri'
require 'fileutils'

def pluginManager()
  puts "Plugins you should install:"
  puts "Luckperms - luckperms.net/download (Use the Bukkit version)"
  puts "SimpleClaimSystem - hangar.papermc.io/Xyness/SimpleClaimSystem"
  puts "TeaksTweaks (150+ togglelable tweaks) - hangar.papermc.io/teakivy/TeaksTweaks"
  puts "Github: github.com/gitipedras/redserver"
end

def getServerDownload(path, serverVersion, autoi)
  url = "https://jar.setup.md/download/paper/#{serverVersion}/latest"
  uri = URI.parse(url)
  
  # Append the file name to the directory path
  file_name = "launch.jar"
  file_path = File.join(path, file_name)
  
  puts 'Downloading server jar file...'.colorize(:yellow)
  File.open(file_path, 'wb') do |local_file|
    local_file.write URI.open(uri).read
  end

  if autoi == true
    puts '[AutoInstall] Server Install successfull!'.colorize(:yellow)
    exit

  else
    puts 'Server executable has been downloaded'
  end
end

def sudormrfslash()
  FileUtils.rm_rf('server/')
  FileUtils.rm('options.txt')
end

def createServer(serverName, serverVersion, eulaAccepted)

  FileUtils.mkdir_p 'server/'

  if eulaAccepted == true
    # aka.ms/mc-eula
    # to accpet it
  
    Dir.chdir("server/") do
      eulaFile = File.new("eula.txt", "w")
      eulaFile.puts("eula=true")
      eulaFile.close
    end
    
  else
    # Do not accept eula (do nothing)
    # pass - in python
  end

  out_file = File.new("options.txt", "w")
  out_file.puts("
  {
    \"serverName\": \"#{serverName}\",
    \"serverVersion\": \"#{serverVersion}\",
    \"eulaAccepted\": \"#{eulaAccepted}\"
  }
  ")

  path = "server/"
  autoi = true
  getServerDownload(path, serverVersion, autoi)

end

def autoInstall()

  puts "Your server will be auto-installed from auto.json".colorize(:yellow) 
  # Read JSON data from options.txt
  autofile = File.read('auto.json')

  # Parse the JSON data
  autofile = JSON.parse(autofile)

  serverName = autofile['serverName']
  serverVersion = autofile['serverVersion']
  eulaAccepted = autofile['eulaAccepted']

  createServer(serverName, serverVersion, eulaAccepted)

end