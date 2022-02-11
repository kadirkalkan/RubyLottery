require_relative "../models/user"
require_relative "../models/lottery"

module LotteryManager
	
	@@game_fee = 5;

	def can_user_play(user)
		if(user.nil?)
			return false
		end
		user.money >= @@game_fee
	end

	def get_game_fee(user) 
		if !can_user_play(user)
			return nil
		end
		user.money -= @@game_fee
		return user
	end

	def get_random_numbers
		numbers = []
		6.times { numbers << (rand(10).to_i + 1) }
		return numbers
	end

	def get_random_users
		users = []
		[2..100].each { |count| users << User.new(count, "users_#{count}", "users_#{count}", "#{(rand(100) + 1).to_i * 5}" ) }
		return users
	end

	def get_random_lotteries
		lotteries = []
		users = get_random_users()

		users.each do |user| 
			lotteries << Lottery.new(user, get_random_numbers())
		end

		return lotteries
	end

	def find_winners(lotteries, lucky_numbers)
		if lotteries.nil? || lotteries.count == 0 || lucky_numbers.nil? || lucky_numbers.count == 0
			return nil
		end
		lotteries.each { |lottery| lottery.matched_count = get_matched_count(lucky_numbers, lottery.numbers) }
		return lotteries
	end

	def find_user_lottery(lotteries, user) 
		if lotteries.nil? || lotteries.count == 0 || user.nil?
			return nil
		end
		lotteries.find { |lottery| lottery.user == user }
	end

	def get_matched_count(lucky_numbers, numbers)
		if lucky_numbers.nil? || lucky_numbers.count == 0 || numbers.nil? || numbers.count == 0
			return 0
		end

		numbers.count { 
			|number|
			lucky_numbers.include?(number)
		}
	end

	def get_average_matched_count(lotteries) 
		count = 0
		lotteries.each { |lottery| count += lottery.matched_count }
		count = count / lotteries.count
		return count
	end

end