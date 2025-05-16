class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find_by(id: params[:id])
    unless @order_detail
      redirect_to admin_orders_path, alert: '注文詳細が見つかりません。'
      return
    end

    @order = @order_detail.order
    @order_details = @order.order_details

    if @order_detail.update(order_detail_params)
      if @order_detail.making_status == 'in_production'
        @order.update(status: :in_production)
      else
        is_updated = @order_details.all? { |detail| detail.making_status == 'production_completed' }
        @order.update(status: :preparing_for_shipping) if is_updated
      end

      redirect_to admin_order_path(@order), notice: '注文ステータスが更新されました'
    else
      flash[:alert] = @order_detail.errors.full_messages.join(', ')
      render :edit
    end
  end

  private

  def order_detail_params
    params.require(:order_detail).permit(:order_id, :item_id, :price, :amount, :making_status)
  end

end