FactoryBot.define do
  factory :event, aliases: [:invited_events, :hosted_events] do
    host  
    title { Faker::Lorem.words(number: 5) }
    location { Faker::Address.city }
    description { Faker::Lorem.paragraph(sentence_count: 2) }
    start_time { Faker::Time.between(from: Time.zone.now + 1, to: Time.zone.now + 10.days) }
  end
end