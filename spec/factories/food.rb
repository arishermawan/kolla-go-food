FactoryGirl.define do
  factory :food do
    name { Faker::Food.dish }
    description "Betawi"
    price 10000.0
    image_url nil
  end
end