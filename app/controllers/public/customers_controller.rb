class Public::CustomersController < ApplicationController
  before_action :is_matching_login_user

  def show
    @customer = Customer.find(params[:id])
  end

  def edit
    @customer = Customer.find(params[:id])
  end

  def update
    @customer = Customer.find(params[:id])
    if @customer.update(customer_params)
      redirect_to customer_path(@customer)
    else 
      @customer = Customer.find(params[:id])
      render :edit
    end
  end

  def check
  end

  def withdraw
    @customer = Customer.find(params[:id])
    @customer.update(is_active: false)
    reset_session
    flash[:notice] = "退会処理を実行しました"
    redirect_to root_path
  end

  private

  def customer_params
    params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana, :email, :postal_code, :address, :phone_number)
  end

  def is_matching_login_user
    customer = Customer.find(params[:id])
    unless customer.id == current_customer.id
      redirect_to customer_path(current_customer)
    end
  end
end
