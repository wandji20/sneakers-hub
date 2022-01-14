class SessionsController < ApplicationController
  include Authenticate
  def new
  end
  
  def create
    user = User.find_by_email(sessions_params[:email])
    if user&.authenticate(sessions_params[:password])
      login(user)
      location = session[:previous_path] || root_path
      redirect_to location
    else
      flash.now[:alert] = 'Invalid Email/Password'
      render :new, status: :unprocessable_entity
    end
  end
  private
  def sessions_params
    params.require(:session).permit(:email, :password, :remember_me)
  end
end