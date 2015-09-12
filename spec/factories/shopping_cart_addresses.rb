FactoryGirl.define do
  factory :shopping_cart_address, :class => 'ShoppingCart::Address' do
    address { Faker::Address.street_address }
    zip_code { Faker::Address.zip_code }
    city { Faker::Address.city }
    phone { Faker::PhoneNumber.cell_phone }
    country "us"
    # user_id 2
  end

end
