FactoryGirl.define do
  factory :food do
    sequence(:name) { |n| "Food-#{n}" }
    description { Faker::Food.ingredient }
    price 10000.0

    # association :category
    # association :restaurant
  end

  factory :invalid_food, parent: :food do
    name nil
    description nil
    price 10000.0
  end
end
