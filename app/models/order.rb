class Order < ApplicationRecord
  belongs_to :customer
  has_many :order_details, dependent: :destroy

  enum payment_method: { credit_card: 0, transfer: 1 }

  enum status: { waiting_for_payment: 0, confirmed_payment: 1, in_production: 2, preparing_for_shipping: 3, shipped: 4 }

  validates :customer_id, presence: true
  validates :postal_code, presence: true
  validates :address, presence: true
  validates :name, presence: true
  validates :postage, presence: true
  validates :total_amount, presence: true
  validates :payment_method, presence: true
  validates :status, presence: true

  SHIPPING_COST = 800

  def get_items_total_price
    items_total_price = 0
    order_details.each do |order_detail|
      items_total_price += order_detail.price * order_detail.amount
    end
    items_total_price
  end

  def get_total_amount
    total_amount = 0
    order_details.each do |order_detail|
      total_amount += order_detail.amount
    end
    total_amount
  end

  def get_postage
    SHIPPING_COST
  end
end
