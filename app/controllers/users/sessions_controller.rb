# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  # def new
  #   super
  # end
  def create
    user = User.find_by(email: params[:client_user][:email])
    if user&.client?
      super
    else
      flash[:alert] = "Wrong email or password"
      redirect_to new_client_user_session_path
    end
  end

  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  protected

  def after_sign_out_path_for(resource_or_scope)
    new_client_user_session_path
  end
end
