FactoryBot.define do
  factory :event do
    name { "Qui porro quaerat et." }
    description { "Incidunt vel modi. Molestiae omnis debitis. Aliquam aliquid adipisci." }
    location { "South Carterton" }
    event_date { "Tue, 12 Nov 2024 03:24:29.391035000 UTC +00:00" }
    total_tickets { 330 }
    association :user
  end
end