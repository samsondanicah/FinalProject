class Users::ProfilesController < ApplicationController
  def show; end

  def edit
    @user = current_client_user
  end
end
