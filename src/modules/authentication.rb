module Authentication
	require 'bcrypt'

	def self.create_hash_digest(password)
		BCrypt::Password.create(password)
	end

	def self.verify_hash_digest(password)
    	BCrypt::Password.new(password)
  	end

end
