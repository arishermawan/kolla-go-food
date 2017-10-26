FactoryGirl.define do
  factory :food do
    name {Faker::Food.dish}
    description {Faker::Food.Ingredient}
    price 10000.0
  end

  factory :invalid_food, parent::food do
    name nil
    descriptiion nil
  end

end