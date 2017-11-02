FactoryGirl.define do
  factory :user do
    username "arishermawan"
    password "okbro1234"
    password_confirmation "okbro1234"

  end

  factory :invalid_user, parent: :user do
    username nil
    password nil
    password_confirmation nil

  end
end
