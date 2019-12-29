class SessionsController < ApplicationController
   def create
      @user = User.find_by_credentials(params[:user][:email], params[:user][:password])
      if @user
         login_user!(@user)
         redirect_to artists_url
      else
         flash.now[:errors] ||= []
         flash.now[:errors] << "Those were invalid user credentials. Please try again"
         render :new
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