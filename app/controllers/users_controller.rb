class UsersController < ApplicationController
  def new
    @user = user.new
  end

  def create
    @user = user.new(user_params)
    if @user.save
      flash.now[:notice] = 'Account Successfully Created'
      render turbo_stream: turbo_stream.update('notice') { partial: 'shared/notice' }
    else
      flash.now[:alert] = 'Something went wrong'
      respond_to |format| do
        format.turbo_stream: do
          render turbo_stream:
            [
              turbo_stream.update('new_user', partial: 'users/form', locals: { user: @user} )
            ]
        end
      end
    end
  end

  def update
  end

  def user_params
    params.require(:user).permit(:email, :ppassword)
  end
end
