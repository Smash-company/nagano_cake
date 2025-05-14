class CreateItems < ActiveRecord::Migration[6.1]
  def change
    create_table :items do |t|

      t.string :name, null: false
      t.text :opinion, null: false
      t.integer :price, null: false
      t.boolean :is_active, default: true, null: false
      t.timestamps
    end
  end
end
