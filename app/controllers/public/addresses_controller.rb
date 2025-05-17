class Public::AddressesController < ApplicationController
  before_action :authenticate_customer!

  def index
    @addresses = current_customer.addresses
    @address = Address.new
  end

  def edit
    @address = Address.find(params[:id])
  end

  def create
    @address = current_customer.addresses.new(address_params)
    if @address.save
      redirect_to addresses_path, notice: '配送先が登録されました。'
    else
      @addresses = current_customer.addresses
      render :index
    end
  end

  def update
    @address = Address.find(params[:id])
    if @address.update(address_params)
      redirect_to addresses_path, notice: '配送先が更新されました。'
    else
      render :edit
    end
  end

  def destroy
    Address.find(params[:id]).destroy
    redirect_to addresses_path, notice: '配送先が削除されました。'
  end

  private

  def address_params
    params.require(:address).permit(:name, :postal_code, :address)
  end

end
