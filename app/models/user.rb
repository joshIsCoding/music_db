class User < ApplicationRecord
   validates :email, :session_token, :password_digest, presence: true
   validates :password, allow_nil: true, length: { minimum: 5 }

   # checks pre-existence of session token for User instances that should already 
   # be logged in, such as those used in HTTP requests
   after_initialize :ensure_session_token
   
   attr_reader :password

   def self.generate_session_token
      SecureRandom::urlsafe_base64(16)
   end

   def password=(password)
      self.password_digest = BCrypt::Password.create(password)
   end

   def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
   end

   def reset_session_token!
      self.session_token = self.class.generate_session_token
      self.save!
      self.session_token
   end

   private

   def ensure_session_token
      self.session_token ||= self.class.generate_session_token
   end
   
end
