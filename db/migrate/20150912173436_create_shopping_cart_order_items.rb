class CreateShoppingCartOrderItems < ActiveRecord::Migration
  def change
    create_table :shopping_cart_order_items do |t|
      t.decimal :price, precision: 8, scale: 2
      t.integer :quantity
      t.belongs_to :orders, index: true, foreign_key: true
      t.integer :product_id

      t.timestamps null: false
    end
  end
end
