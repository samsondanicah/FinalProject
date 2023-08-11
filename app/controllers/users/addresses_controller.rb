class Users::AddressesController < ApplicationController
  before_action :set_address, only: [:edit, :update, :destroy]

  def index
    @addresses = current_client_user.addresses.all
  end

  def new
    @address = Address.new
  end

  def create
    @address = Address.new(address_params)
    @address.user = current_client_user
    if @address.save
      flash[:notice] = 'Address created successfully'
      redirect_to addresses_path
    else
      flash.now[:alert] = 'Address create failed'
      render :new, status: :unprocessable_entity
    end
  end

  def edit; end

  def update
    if @address.update(address_params)
      flash[:notice] = 'Address updated successfully'
      redirect_to addresses_path
    else
      flash.now[:alert] = 'Address update failed'
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @address.destroy
    flash[:notice] = 'Address destroyed successfully'
    redirect_to addresses_path
  end

  private

  def set_address
    @address = current_client_user.addresses.find(params[:id])
  end

  def address_params
    params.require(:address).permit(:genre, :name, :street_address, :phone_number, :remark, :is_default, :user, :address_region_id, :address_province_id, :address_city_id, :address_barangay_id)
  end
end
