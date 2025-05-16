class AddOrderIdToOrderDetails < ActiveRecord::Migration[6.1]
  def change
    add_column :order_details, :order_id, :integer, null: false
  end
end
