require_relative "../modules/authentication"

class User

	attr_accessor :id, :username, :password, :money

	def initialize(id, username, password, money = 0) 
		@id = id,
		@username = username
		@password = Authentication.create_hash_digest(password)
		@money = money
	end

	def to_s
		"User Info \t : #{@username} \nBalance \t : $#{money}"
	end

end