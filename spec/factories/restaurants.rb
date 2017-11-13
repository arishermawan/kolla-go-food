# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant do
    name "Restaurant890"
    address "Ini Restaurant"
  end

  factory :invalid_restaurant, parent: :restaurant do
    name nil
    address nil
  end
end
