class Lottery

	attr_accessor :user, :numbers, :matched_count

	def initialize(user, numbers) 
		@user = user
		@numbers = numbers
	end

end