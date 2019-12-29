class ApplicationController < ActionController::Base
   def current_user
      return nil unless session[:session_token]
      @current_user ||= User.find_by(session[:session_token])
   end

   def logged_in?
      !current_user.nil?
   end

   def login_user!(user)
      session[:session_token] = user.reset_session_token!
      nil
   end
end
