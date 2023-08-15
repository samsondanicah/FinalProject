# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  def new
    cookies[:promoter] ||= params[:promoter]
    super
  end

  # POST /resource
  def create
    super
    parent = User.find_by(email: cookies[:promoter])
    self.resource.update(parent: parent)
  end
end
