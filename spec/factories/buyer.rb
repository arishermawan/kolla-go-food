FactoryGirl.define do
  factory :buyer do
    email { Faker::Internet.email }
    name { Faker::Name.name }
    phone "082310232303"
    address "jln Azalea Raya no 3 lembah hijau lippo cikarang"

  end

  factory :invalid_buyer, parent: :buyer do
    email nil
    name nil
    phone nil
    address nil
  end
end