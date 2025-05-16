class Item < ApplicationRecord

  has_many :cart_items, dependent: :destroy
  belongs_to :genles

end
