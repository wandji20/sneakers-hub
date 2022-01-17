class UsersController < ApplicationController

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      flash.now[:notice] = 'Account Successfully Created'
      login(@user)
      UserMailer.welcome_email(@user.id).deliver_later
      location = session[:previous_path] || root_path
      redirect_to location
    else
      flash.now[:alert] = 'Something went wrong'
      respond_to do |format|
        format.html { render :new, status: :unprocessable_entity }
        # format.turbo_stream do
        #   render turbo_stream:
        #     [
        #       turbo_stream.update('alert', partial: 'shared/alert'),
        #       turbo_stream.replace('new_user', partial: 'users/form', locals: { user: @user})
        #     ]
        # end
      end
    end
  end

  def update
  end

  def user_params
    params.require(:user).permit(:email, :password, :remember_me)
  end
end
