# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :category do
    # name "Traditional Food"
    sequence :name do |n|
      "category#{n}"
    end
  end

  factory :invalid_category, parent: :category do
    name nil
  end
end
