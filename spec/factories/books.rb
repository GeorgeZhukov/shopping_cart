FactoryGirl.define do
  factory :book do
    title { Faker::Book.title }
    price { Faker::Commerce.price }
    in_stock { Faker::Number.between(50, 200) }
  end

end
