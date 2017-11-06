# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :voucher do
    code "GOJEKINAJA"
    valid_from "2017-11-06"
    valid_through "2017-11-06"
    amount "9.99"
    unit_type 1
    max_amount "9.99"
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
