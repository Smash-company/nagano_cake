class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!
  
  def new
    @order = Order.new
    @customer = current_customer
  end

  def check
    @order = Order.new
    @cart_items = CartItem.where(customer_id: current_customer.id)
    @postage = 800 
    @selected_payment_method = params[:order][:payment_method]

    @total_price = 0

    @address_type = params[:order][:address_type]
    case @address_type
    when "customer_address"
      @selected_address = current_customer.postal_code + " " + current_customer.address + " " + current_customer.last_name + current_customer.first_name
    when "registered_address"
      unless params[:order][:registered_address_id] == ""
        selected = Address.find(params[:order][:registered_address_id])
        @selected_address = selected.postal_code + " " + selected.address + " " + selected.name
      else	 
        render :new
      end
    when "new_address"
      unless params[:order][:postal_code] == "" && params[:order][:address] == "" && params[:order][:name] == ""
        @selected_address = params[:order][:postal_code] + " " + params[:order][:address] + " " + params[:order][:name]
      else
        render :new
      end
    end

    @cart_items = current_customer.cart_items.all
    @order.customer_id = current_customer.id
    @order.postage = @order.get_postage

  end

  def confirm
  end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save

    #order_detailの保存
    @cart_items = current_customer.cart_items
    current_customer.cart_items.each do |cart_item|
      @order_detail = OrderDetail.new
      @order_detail.item_id = cart_item.item_id
      @order_detail.order_id = @order.id
      @order_detail.price = cart_item.item.add_tax_price
      @order_detail.amount = cart_item.amount
      @order_detail.save
    end

    current_customer.cart_items.destroy_all
    redirect_to orders_confirm_path
  end

  def index
    @orders = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_details= OrderDetail.where(order_id: @order.id)
  end

  private

  def order_params
    params.require(:order).permit(:payment_method, :name, :address, :postal_code, :payment, :total_amount, :status, :customer_id)
  end

end