FactoryGirl.define do

  factory :shopping_cart_order_item, :class => 'ShoppingCart::OrderItem' do
    price { Faker::Commerce.price }
    quantity 1 #{ Faker::Number.digit }
    product { create :book }
  end

end
