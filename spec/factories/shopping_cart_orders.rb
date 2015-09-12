FactoryGirl.define do
  factory :shopping_cart_order, :class => 'ShoppingCart::Order' do
    state "in_progress"
    credit_card { create :shopping_cart_credit_card }
    delivery_service { create :shopping_cart_delivery_service }
    user

    association :shipping_address, factory: :shopping_cart_address
    association :billing_address, factory: :shopping_cart_address
  end

end
