class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    #@orders = Orders.all 必要かもしれない
    @order_details = @order.order_details
  end

  def update
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @order.update(order_params)

    if @order.status == 'confirmed_payment'
      @order_details.update_all(making_status: 1)
    end
    
    redirect_to admin_order_path(@order), notice: '注文ステータスが更新されました'
  end

  private

  def order_params
    params.require(:order).permit(:customer_id, :postal_code, :adress, :name, :postage, :total_amount, :payment_method, :status)
  end

end