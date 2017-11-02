FactoryGirl.define do
  factory :user do
    username { Faker::Internet.unique.user_name }
    password "longpassword"
    password_confirmation "longpassword"

  end

  factory :invalid_user, parent: :user do
    username nil
    password nil
    password_confirmation nil
  end
end
