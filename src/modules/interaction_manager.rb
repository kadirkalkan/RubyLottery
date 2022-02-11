require_relative "lottery_manager"
include LotteryManager

module InteractionManager

	def draw_a_line
		puts "-" * 40
	end

	def login 
		username = ""
		while username.length == 0
			print "Please choose your username : "
			username = gets.chomp
		end

		password = ""
		while password.length == 0
			print "Please choose your password : "
			password = gets.chomp
		end
		
		money = 0
		while money < 5
			print "Please add some balance to play game (min 5): "
			begin
				money = gets.chomp.to_i
			rescue  ArgumentError
				puts "PLEASE ENTER A NUMERIC VALUE"
			end
		end

		user = User.new(1, username, password, money);

		puts "\nYou have successfully logged in."
		draw_a_line()
		puts user
		draw_a_line()
		puts

		return user
	end

	def play(user)
		if user.nil?
			return nil
		end
		numbers = get_numbers_from_user;
		lotteries = []

		lotteries = get_random_lotteries()
		lotteries << Lottery.new(user, numbers)

		lucky_numbers = get_random_numbers()

		lotteries = find_winners(lotteries, lucky_numbers)

		inform_user(user, lucky_numbers, lotteries)
	end

	def get_numbers_from_user
		numbers = []
		puts "Welcome to lottery game! Please enter your numbers in the order given. Each number has to be between 1 and 50"

		counter = 1
		while numbers.count < 6		
			print "Please enter No.#{counter} number : "
			begin
				number = Integer(gets.chomp)
				if number > 0 && number <= 50
					numbers << number
					counter += 1
				else
					puts "Please enter a number between 1 and 50!"
				end
			rescue ArgumentError
				puts "PLEASE ENTER A NUMERIC VALUE"
			end
		end

		return numbers;
	end

	def inform_user(user, lucky_numbers, lotteries)
		if lotteries.nil? || lotteries.count == 0 || user.nil? || lucky_numbers.nil? || lucky_numbers.count == 0
			return nil
		end
		user_lottery = find_user_lottery(lotteries, user)

		draw_a_line()
		puts "The Lucky numbers was : #{lucky_numbers.join(" - ")}"
		puts "Your numbers was : #{user_lottery.numbers.join(" - ")}"
		draw_a_line()
		puts "Count of numbers that you know is #{user_lottery.matched_count}"
		puts "Avarage count of numbers that people know is #{get_average_matched_count(lotteries)}"
		draw_a_line()
		puts
	end
end