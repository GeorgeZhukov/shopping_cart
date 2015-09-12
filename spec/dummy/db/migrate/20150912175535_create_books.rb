class CreateBooks < ActiveRecord::Migration
  def change
    create_table :books do |t|
      t.string :title
      t.decimal :price, precision: 8, scale: 2
      t.integer :in_stock

      t.timestamps null: false
    end
  end
end
