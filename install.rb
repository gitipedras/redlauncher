require 'colorize'

puts 'Downloading files...'.colorize(:green)
sleep(3)

reddir = 'red_files'

Dir.mkdir(reddir)

File.new("#{reddir}/options.txt", "w")