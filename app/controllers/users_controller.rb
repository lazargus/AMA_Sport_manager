class UsersController < ApplicationController

  def show
    @user = current_user
  end

  def edit
    @user = current_user
  end

  def update
    if current_user.update(user_params)
      redirect_to user_path(current_user), notice: 'Profile was successfully updated.'
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :age, :ranking, :nationality)
  end
end
