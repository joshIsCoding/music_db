class User < ApplicationRecord
   validates :email, :session_token, :password_digest, presence: true
   validates :password, allow_nil: true, length: { minimum: 5 }

   attr_reader :password

   def password=(password)
      self.password_digest = BCrypt::Password.create(password)
   end

   def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
   end

   
   
end
