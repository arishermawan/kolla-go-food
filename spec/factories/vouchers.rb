# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    sequence(:code) { |n| "Code-#{n}" }
    valid_from "2017-11-06"
    valid_through "2017-11-30"
    amount "15.0"
    unit_type "Rp (Rupiah)"
    max_amount "20000"
  end

  factory :invalid_voucher, parent: :voucher do
    code nil
    valid_from nil
    valid_through nil
    amount nil
    unit_type nil
    max_amount nil
  end
end
