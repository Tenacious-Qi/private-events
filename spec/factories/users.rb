FactoryBot.define do
  factory :user, aliases: [:host, :invitee] do
    name { Faker::Name.name }
    email { Faker::Internet.unique.email }
    password { Faker::Internet.password }
  end
end