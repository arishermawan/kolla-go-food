FactoryGirl.define do
  factory :order do
    name { Faker::Name.name }
    address { Faker::Address.street_address }
    email { Faker::Internet.email }
    payment_type { Faker::Number.between(0,2) }

  end

  factory :invalid_buyer, parent: :buyer do
    name nil
    address nil
    email nil
    payment_type nil
  end
end