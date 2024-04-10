FactoryBot.define do
  factory :booking do
    ticket_quantity { 7 }
    association :user
    association :event
  end
end