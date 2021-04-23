FactoryBot.define do
  factory :event, aliases: [:created_event, :invited_events, :hosted_events] do
    host  
    title { Faker::Lorem.characters(number: 10) }
    location { Faker::Address.city }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    start_time { Faker::Time.between(from: Time.zone.now + 2.days, to: Time.zone.now + 10.days) }

  end
end