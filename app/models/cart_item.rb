class CartItem < ApplicationRecord
  belongs_to :customer
  belongs_to :item


  def subtotal
    item.add_tax_price * amount
  end

validates :customer_id, presence: true
validates :item_id, presence: true
validates :amount, presence: true, numericality: { greater_than_or_equal_to: 1 }
end