class ApplicationController < ActionController::Base
   # skip filter at individual controller level for certain essential actions 
   before_action :require_login
   helper_method :logged_in?, :current_user
   def current_user
      return nil unless session[:session_token]
      @current_user ||= User.find_by(session_token: session[:session_token])
   end

   def logged_in?
      !current_user.nil?
   end

   def login_user!(user)
      session[:session_token] = user.reset_session_token!
      nil
   end

   private 
   def require_login
      unless logged_in?
         flash[:errors] ||= []      
         flash[:errors] << "You must be logged in to do that."
         redirect_to new_session_url
      end
   end

end
