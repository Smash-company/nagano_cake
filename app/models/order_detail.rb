class OrderDetail < ApplicationRecord
  belongs_to :order
  belongs_to :item

  enum making_status: { unable_manufacture: 0, waiting_for_manufacture: 1, in_production: 2, production_completed: 3 }

  validates :order_id, presence: true
  validates :item_id, presence: true
  validates :price, presence: true
  validates :amount, presence: true
  validates :making_status, presence: true

  def get_subtotal
    item.add_tax_price * amount
  end

end
