class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_admin!

  def index 
    @users = User.all
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to admin_users_path, notice: 'User was successfully updated.'
    else
      render :index, status: :unprocessable_entity
    end
  end

  private

  def authorize_admin!
    unless current_user.admin?
      redirect_to root_path
    end
  end

  def user_params
    params.require(:user).permit(:admin)
  end
end
