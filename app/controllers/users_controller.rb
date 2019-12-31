class UsersController < ApplicationController
   skip_before_action :require_login
   def create
      @user = User.new(user_params)
      if @user.save
         activation_msg = UserMailer.activation_email(@user)
         activation_msg.deliver_now
         render :show
      else
         flash.now[:errors] = @user.errors.full_messages
         render :new
      end
   end

   def new
      @user = User.new
      render :new
   end

   def activate
      @user = User.find_by(activation_token: params[:activation_token])
      if @user
         unless @user.activated
            activate!(@user)
            flash[:info] = "Success! Your account has been activated."
         end
         redirect_to new_session_url
      else
         flash.now[:errors] = "Something went wrong. Please try re-registering."
         render :new
      end
   end

   private
   def user_params
      params.require(:user).permit(:email, :password)
   end

end