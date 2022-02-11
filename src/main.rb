require_relative "modules/lottery_manager"
require_relative "modules/interaction_manager"
include LotteryManager
include InteractionManager

user = login()

game_stoped = false
while can_user_play(user)
	user = get_game_fee(user);
	play(user)
	print "Do you want to play again ? ( Y / N ) : "
	choice = gets.chomp.downcase
	if !choice.eql?("y")
		game_stoped = true
		break
	else
		loop do 
			print "Please enter your \"Password\" to verify your request : "
			password = gets.chomp
			break if user.password == password
			puts "Password is wrong please try again..."
		end
	end
end

if !game_stoped
	puts "Sorry You don't have enough money to play anymore"
end