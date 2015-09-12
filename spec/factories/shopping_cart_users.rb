FactoryGirl.define do
  factory :shopping_cart_user, :class => 'ShoppingCart::User' do
    email { Faker::Internet.email }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password "password"
    avatar { Faker::Avatar.image }


    factory :admin do
      is_admin true
    end

    factory :facebook_user do
      provider "facebook"
      uid { Faker::Number.number(15) }
    end

    factory :user_with_addresses do
      association :shipping_address, factory: :address
      association :billing_address, factory: :address
    end
  end

end
