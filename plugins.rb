def pluginManager()


puts 'Options for plugin manager: install, remove'
printf 'Option>'.colorize(:yellow)

option = gets.chomp

case option
	when 'install'
		printf 'Plugin Name:'
		plugname = gets.chomp


	when 'remove'
		printf 'jarfile name:'
		jarname = gets.chomp

end	



end