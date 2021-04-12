FactoryBot.define do
  factory :user do
    name
    email
    password { 123 }
  end
end
