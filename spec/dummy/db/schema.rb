# encoding: UTF-8
# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20150912175550) do

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "in_stock"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "shopping_cart_addresses", force: :cascade do |t|
    t.text     "address"
    t.string   "zip_code"
    t.string   "city"
    t.string   "phone"
    t.string   "country"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_cart_credit_cards", force: :cascade do |t|
    t.string   "number"
    t.string   "CVV"
    t.integer  "expiration_month"
    t.integer  "expiration_year"
    t.string   "first_name"
    t.string   "last_name"
    t.integer  "user_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "shopping_cart_delivery_services", force: :cascade do |t|
    t.string   "name"
    t.decimal  "price",      precision: 8, scale: 2
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  create_table "shopping_cart_order_items", force: :cascade do |t|
    t.decimal  "price",      precision: 8, scale: 2
    t.integer  "quantity"
    t.integer  "order_id"
    t.integer  "product_id"
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "shopping_cart_order_items", ["order_id"], name: "index_shopping_cart_order_items_on_order_id"

  create_table "shopping_cart_orders", force: :cascade do |t|
    t.datetime "completed_date"
    t.string   "state"
    t.integer  "user_id"
    t.integer  "delivery_service_id"
    t.integer  "credit_card_id"
    t.integer  "shipping_address_id"
    t.integer  "billing_address_id"
    t.string   "number"
    t.decimal  "total_price",         precision: 8, scale: 2
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
  end

  add_index "shopping_cart_orders", ["credit_card_id"], name: "index_shopping_cart_orders_on_credit_card_id"
  add_index "shopping_cart_orders", ["delivery_service_id"], name: "index_shopping_cart_orders_on_delivery_service_id"

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
