class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find_by(id: params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details.all
    @order_detail.update(order_detail_params)
    
    is_updated = true
      if @order_detail.making_status == 'in_production'
         @order.update(status: 2)
      else
        @order_details.each do |order_detail|
          if order_detail.making_status != 'production_completed'
          is_updated = false
          end
        end
        @order.update(status: 'preparing_for_shipping') if is_updated
      end
      redirect_to admin_order_path(@order), notice: '制作ステータスが更新されました'
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end

end