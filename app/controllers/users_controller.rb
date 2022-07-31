class UsersController < ApplicationController
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session.delete(:order_id)
      login(@user)
      ShoppingCart.create(user_id: @user.id)
      transfer_shopping_cart(@user)
      # UserMailer.welcome_email(@user.id).deliver_later
      flash[:notice] = 'Account Successfully Created'
      redirect_to redirect_location
    else
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update; end

  def user_params
    params.require(:user).permit(:email, :password, :remember_me)
  end
end
