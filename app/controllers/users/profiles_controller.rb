class Users::ProfilesController < ApplicationController
  def show; end

  def edit
    @user = current_client_user
  end

  def update
    @user = current_client_user
    if @user.update(user_params)
      redirect_to profiles_path, notice: 'User was successfully updated.'
    end
  end

  def user_params
    params.permit(:phone_number, :username, :password)
  end
end
