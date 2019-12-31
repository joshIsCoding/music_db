class SessionsController < ApplicationController
   skip_before_action :require_login, only: [:new, :create]
   def create
      @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
      if @user.nil?
         flash.now[:errors] = "Those were invalid user credentials. Please try again"
         render :new
      elsif !@user.activated
         flash[:errors] ||= []
         flash[:errors] << "This user has not been activated! Please check your emails."
         redirect_to new_user_url
      else
         login_user!(@user)
         redirect_to artists_url
      end
   end

   def new
      render :new
   end

   def destroy
      if current_user
         current_user.reset_session_token!
         session[:session_token] = nil
      end
      redirect_to new_session_url
   end


end