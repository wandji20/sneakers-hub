class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session.delete(:order_id)
      login(@user)
      transfer_current_order(@user)
      UserMailer.welcome_email(@user.id).deliver_later
      flash[:notice] = 'Account Successfully Created'
      redirect_to redirect_location
    else
      flash[:alert] = 'Something went wrong'
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
  end

  def user_params
    params.require(:user).permit(:email, :password, :remember_me)
  end
end
