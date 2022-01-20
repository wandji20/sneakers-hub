class SessionsController < ApplicationController
  def new; end

  def create
    user = User.find_by_email(sessions_params[:email])
    if user&.authenticate(sessions_params[:password])
      login(user)
      remember_user(user)
      transfer_shopping_cart(user)
      flash[:notice] = 'Welcome'
      redirect_to redirect_location
    else
      flash.now[:alert] = 'Invalid Email/Password'
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    logout if logged_in?
    flash.now[:notice] = 'You have successfully logout'
    redirect_to redirect_location
  end

  private

  def sessions_params
    params.require(:session).permit(:email, :password, :remember_me)
  end

  def remember_user(user)
    sessions_params[:remember_me] == '1' ? remember(user) : forget(user)
  end
end
