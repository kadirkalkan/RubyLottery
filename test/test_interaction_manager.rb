require "test/unit"
require_relative "../src/models/user"
require_relative "../src/models/lottery"
require_relative "../src/modules/interaction_manager"
include InteractionManager

class TestInteractionManager < Test::Unit::TestCase

	@@user =  User.new(1, "kadir", "123", 100)
	@@lotteries = [Lottery.new(@user, ([1,2,3,4,5,6]))]
	@@lucky_numbers = [1,2,3,4,5,6];
	
	def test_play
		user = nil

		assert_equal(nil, play(user))
	end

	def test_inform_user_lotteries_nil
		user = @@user
		lucky_numbers = @@lucky_numbers
		lotteries = nil

		assert_equal(nil, inform_user(user, lucky_numbers, lotteries))
	end

	def test_inform_user_lotteries_empty
		user = @@user
		lucky_numbers = @@lucky_numbers
		lotteries = []

		assert_equal(nil, inform_user(user, lucky_numbers, lotteries))
	end

	def test_inform_user_lucky_numbers_nil
		user = @@user
		lucky_numbers = nil
		lotteries = @@lotteries

		assert_equal(nil, inform_user(user, lucky_numbers, lotteries))
	end

	def test_inform_user_lucky_numbers_empty
		user = @@user
		lucky_numbers = []
		lotteries = @@lotteries

		assert_equal(nil, inform_user(user, lucky_numbers, lotteries))
	end

	def test_inform_user_user_nil
		user = nil
		lucky_numbers = @@lucky_numbers
		lotteries = @@lotteries

		assert_equal(nil, inform_user(user, lucky_numbers, lotteries))
	end

end

