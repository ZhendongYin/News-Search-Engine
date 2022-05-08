# Yifan Zhu

class SessionsController < ApplicationController
  before_action :load_media
  # user login page
  def new
    @index = :null
  end

  # user loginn
  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      forwarding_url = session[:forwarding_url]
      reset_session
      remember(user)
      log_in user
      redirect_to "/"
    else
      flash.alert = 'Invalid email/password combination'
      redirect_to new_session_path
    end
  end
  # user logout
  def destroy
    log_out
    redirect_to "/"
  end

  # user sign up page
  def sign
    @index = :null
    @user = User.new
  end
  # user sign up
  def save
    @user = User.new(user_params)
    if @user.save
      reset_session
      log_in @user
      flash[:success] = "Welcome to Bingle!"
      redirect_to "/"
    else
      flash.alert = @user.errors.full_messages.first
      redirect_to signup_sessions_path
    end
  end

  private
  def user_params
    params.require(:session).permit(:name, :email, :password, :password_confirmation)
  end
end