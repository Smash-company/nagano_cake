class AddItemIdToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :order_details, :item_id, :integer, null: false
  end
end
