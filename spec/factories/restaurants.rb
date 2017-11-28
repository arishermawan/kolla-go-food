# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :restaurant do
    sequence(:name) { |n| "Restaurant-#{n}" }
    address "kolla sabang, jakarta"
  end

  factory :invalid_restaurant, parent: :restaurant do
    name nil
    address nil
  end
end
