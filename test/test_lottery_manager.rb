require "test/unit"
require_relative "../src/models/user"
require_relative "../src/models/lottery"
require_relative "../src/modules/lottery_manager"
include LotteryManager

class TestLotteryManager < Test::Unit::TestCase

	@@user =  User.new(1, "kadir", "123", 100)
	@@dummy_user = User.new(2, "dummy", "345", 200)
	@@lucky_numbers = [1,2,3,4,5,6];
	@@numbers = [1,2,3,4,5,6]
	@@mismatched_numbers = [7,8,9,10,11,12]
	@@lotteries = [Lottery.new(@@user, @@numbers), Lottery.new(@@dummy_user, @@mismatched_numbers)]
	

	def test_can_user_play
		user = @@user
		assert_equal(true, can_user_play(user))
	end

	def test_can_user_play_user_nil
		user = nil
		assert_equal(false, can_user_play(user))
	end

	def test_get_game_fee_not_enough_money
		user = @@user
		user.money = 0
		assert_equal(nil, get_game_fee(user))
	end

	def test_find_winners_lotteries_nil
		lotteries = nil
		lucky_numbers = @@lucky_numbers
		assert_equal(nil, find_winners(lotteries, lucky_numbers))
	end

	def test_find_winners_lotteries_empty
		lotteries = []
		lucky_numbers = @@lucky_numbers
		assert_equal(nil, find_winners(lotteries, lucky_numbers))
	end

	def test_find_winners_lucky_numbers_nil
		lotteries = @@lotteries
		lucky_numbers = nil
		assert_equal(nil, find_winners(lotteries, lucky_numbers))
	end

	def test_find_winners_lucky_numbers_empty
		lotteries = @@lotteries
		lucky_numbers = []
		assert_equal(nil, find_winners(lotteries, lucky_numbers))
	end

	def test_find_user_lottery_user_nil
		user = nil
		lotteries = @@lotteries
		assert_equal(nil, find_user_lottery(lotteries, user))
	end

	def test_find_user_lottery_lotteries_nil
		user = @@user
		lotteries = nil
		assert_equal(nil, find_user_lottery(lotteries, user))
	end

	def test_find_user_lottery_lotteries_empty
		user = @@user
		lotteries = []
		assert_equal(nil, find_user_lottery(lotteries, user))
	end

	def test_get_matched_count_numbers_nil
		numbers = nil
		lucky_numbers = @@lucky_numbers
		assert_equal(0, get_matched_count(numbers, lucky_numbers))
	end

	def test_get_matched_count_numbers_empty
		numbers = []
		lucky_numbers = @@lucky_numbers
		assert_equal(0, get_matched_count(numbers, lucky_numbers))
	end

	def test_get_matched_count_lucky_numbers_nil
		numbers = @@numbers
		lucky_numbers = nil
		assert_equal(0, get_matched_count(numbers, lucky_numbers))
	end

	def test_get_matched_count_lucky_numbers_empty
		numbers = @@numbers
		lucky_numbers = []
		assert_equal(0, get_matched_count(numbers, lucky_numbers))
	end

	def test_get_matched_count_lucky_numbers_mismatching
		mismatched_numbers = @@mismatched_numbers
		lucky_numbers = @@lucky_numbers
		assert_equal(0, get_matched_count(mismatched_numbers, lucky_numbers))
	end

	def test_get_matched_count_lucky_numbers_matching
		numbers = @@numbers
		lucky_numbers = @@lucky_numbers
		assert_equal(6, get_matched_count(numbers, lucky_numbers))
	end

	# There are 2 data in "lotteries" first one has 6 matches and other one has 0 and average count is 3
	def test_get_average_matched_count
		lotteries = find_winners(@@lotteries, @@lucky_numbers)
		assert_equal(3, get_average_matched_count(lotteries))
	end

end