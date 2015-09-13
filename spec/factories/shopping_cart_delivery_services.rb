FactoryGirl.define do
  factory :shopping_cart_delivery_service, :class => 'ShoppingCart::DeliveryService' do
    sequence(:name) { |n| "Delivery#{Faker::Lorem.word}#{n}" }
    price { Faker::Commerce.price }
  end

end
