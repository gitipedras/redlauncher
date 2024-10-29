require 'colorize'
require 'open-uri'
require 'fileutils'

def startup()

  FileUtils.mkdir_p "data/"

end

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
    puts 'Server Install successfull!'.colorize(:yellow)
    exit

  else
    puts 'Server executable has been downloaded'
  end
end

def sudormrfslash()
  if File.exist?('server/') || File.exist?('options.txt')
    FileUtils.rm_rf('server/')
    FileUtils.rm('options.txt')
  end

  if File.exist?('server.properties')
    FileUtils.rm('server.properties')
  end
end

def createServer(serverName, serverVersion, eulaAccepted, auti)

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

  if auti == true
    FileUtils.copy_file('server.properties', 'server/server.properties')

  if File.exist?('server.properties')
    FileUtils.rm_rf('server.properties')
  end
  else
    puts
  end

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

  # Read JSON data from options.txt
  default_options = File.read('data/default-server-options.json')
  # Parse the JSON data
  default_options = JSON.parse(default_options)

  merged_data = default_options.merge(autofile) { |key, b_val, a_val| a_val.nil? || a_val.empty? ? b_val : a_val }

  # Process keys to replace symbols like "->" with underscores
  processed_data = merged_data.transform_keys { |key| key.to_s.gsub(/[^0-9a-z]/i, '_') }

  # Define instance variables from the processed data
  processed_data.each do |key, value|
    instance_variable_set("@#{key}", value)
  end

  out_file = File.new("server.properties", "w")

  out_file.puts("
  enable_jmx_monitoring=#{@enable_jmx_monitoring}
  rcon_port=#{@rcon_port}
  level_seed=#{@level_seed}
  gamemode=#{@gamemode}
  enable_command_block=#{@enable_command_block}
  enable_query=#{@enable_query}
  generator_settings=#{@generator_settings}
  enforce_secure_profile=#{@enforce_secure_profile}
  level_name=#{@level_name}
  motd=#{@motd}
  query_port=#{@query_port}
  pvp=#{@pvp}
  generate_structures=#{@generate_structures}
  max_chained_neighbor_updates=#{@max_chained_neighbor_updates}
  difficulty=#{@difficulty}
  network_compression_threshold=#{@network_compression_threshold}
  max_tick_time=#{@max_tick_time}
  require_resource_pack=#{@require_resource_pack}
  use_native_transport=#{@use_native_transport}
  max_players=#{@max_players}
  online_mode=#{@online_mode}
  enable_status=#{@enable_status}
  allow_flight=#{@allow_flight}
  initial_disabled_packs=#{@initial_disabled_packs}
  broadcast_rcon_to_ops=#{@broadcast_rcon_to_ops}
  view_distance=#{@view_distance}
  server_ip=#{@server_ip}
  resource_pack_prompt=#{@resource_pack_prompt}
  allow_nether=#{@allow_nether}
  server_port=#{@server_port}
  enable_rcon=#{@enable_rcon}
  sync_chunk_writes=#{@sync_chunk_writes}
  op_permission_level=#{@op_permission_level}
  prevent_proxy_connections=#{@prevent_proxy_connections}
  hide_online_players=#{@hide_online_players}
  resource_pack=#{@resource_pack}
  entity_broadcast_range_percentage=#{@entity_broadcast_range_percentage}
  simulation_distance=#{@simulation_distance}
  rcon_password=#{@rcon_password}
  player_idle_timeout=#{@player_idle_timeout}
  force_gamemode=#{@force_gamemode}
  rate_limit=#{@rate_limit}
  hardcore=#{@hardcore}
  white_list=#{@white_list}
  broadcast_console_to_ops=#{@broadcast_console_to_ops}
  spawn_npcs=#{@spawn_npcs}
  spawn_animals=#{@spawn_animals}
  log_ips=#{@log_ips}
  function_permission_level=#{@function_permission_level}
  initial_enabled_packs=#{@initial_enabled_packs}
  level_type=#{@level_type}
  text_filtering_config=#{@text_filtering_config}
  spawn_monsters=#{@spawn_monsters}
  enforce_whitelist=#{@enforce_whitelist}
  spawn_protection=#{@spawn_protection}
  resource_pack_sha1=#{@resource_pack_sha1}
  max_world_size=#{@max_world_size}
  serverName=#{@serverName}
  serverVersion=#{@serverVersion}
  eulaAccepted=#{@eulaAccepted}
  ")

out_file.close
  
  auti = true
  createServer(serverName, serverVersion, eulaAccepted, auti)

end