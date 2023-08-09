class UsersController < ApplicationController

  private

  def post_params
    params.require(:users).permit( :image)
  end
end