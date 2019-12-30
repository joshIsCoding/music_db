class UserMailer < ApplicationMailer

   def activation_email(user)
      @user = user
      @url = activate_users_url
      mail(to: @user.email, subject: "Activate Your Account on MusicApp!")
   end
end
