FactoryGirl.define do
  factory :order do
    name { Faker::Name.name }
    address "sarinah, jakarta"
    email { Faker::Internet.email }
    payment_type "Cash"

    # association :voucher
    association :user

  end

  factory :invalid_order, parent: :order do
    name nil
    address nil
    email nil
    payment_type nil
  end
end
