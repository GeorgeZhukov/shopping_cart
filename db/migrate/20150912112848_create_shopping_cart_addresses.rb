class CreateShoppingCartAddresses < ActiveRecord::Migration
  def change
    create_table :shopping_cart_addresses do |t|
      t.text :address
      t.string :zip_code
      t.string :city
      t.string :phone
      t.string :country
      t.integer :user_id

      t.timestamps null: false
    end
  end
end
