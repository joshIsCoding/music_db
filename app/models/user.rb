class User < ApplicationRecord
   validates :email, :session_token, :activation_token, :password_digest, presence: true
   validates :password, allow_nil: true, length: { minimum: 5 }

   # checks pre-existence of session token for User instances that should already 
   # be logged in, such as those used in HTTP requests
   after_initialize :ensure_session_token
   # generates token for activating the user's account
   before_create :generate_activation_token 
   
   attr_reader :password

   def self.find_by_credentials(email, password)
      user = User.find_by(email: email)
      return user if user.is_password?(password)
      nil
   end

   def self.generate_auth_token
      SecureRandom::urlsafe_base64(16)
   end

   def password=(password)
      self.password_digest = BCrypt::Password.create(password)
   end

   def is_password?(password)
      BCrypt::Password.new(self.password_digest).is_password?(password)
   end

   def reset_session_token!
      self.session_token = self.class.generate_auth_token
      self.save!
      self.session_token
   end

   private

   def ensure_session_token
      self.session_token ||= self.class.generate_auth_token
   end
   
   def generate_activation_token
      self.activation_token ||= self.class.generate_auth_token
   end
end
