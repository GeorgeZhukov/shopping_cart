class CreateShoppingCartOrders < ActiveRecord::Migration
  def change
    create_table :shopping_cart_orders do |t|
      t.datetime :completed_date
      t.string :state
      t.integer :user_id
      t.belongs_to :delivery_service, index: true, foreign_key: true
      t.belongs_to :credit_card, index: true, foreign_key: true
      t.integer :shipping_address_id
      t.integer :billing_address_id
      t.string :number
      t.decimal :total_price, precision: 8, scale: 2

      t.timestamps null: false
    end
  end
end
