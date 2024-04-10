FactoryBot.define do
  factory :user do
    first_name { "John" }
    last_name  { "Doe" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password   { "securepassword" }
    # email { "test@example.com" }
    # password { "password" }
  end
end