class MypagesController < ApplicationController
  before_action :authenticate_user!
  def show
  end

  def edit
  end
  def update
    if current_user.update_with_password(user_params)
      redirect_to mypages_path
    else
      redirect_to edit_mypages_path
    end
  end

  private
  def user_params
    params.require(:user).permit(:name, :current_password, :password, :password_confirmation)
  end
end
