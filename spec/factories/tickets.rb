FactoryBot.define do
  factory :ticket do
    association :booking
    association :event  
  end
end
