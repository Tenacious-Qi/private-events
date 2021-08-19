users = []
events = []

# default login for people to try site
users << User.create(name: 'Foo Bar',
                     email: 'foo@bar.com',
                     password: 'foobar'
)

12.times do |n|
  users << User.create(name: Faker::Name.name, 
                       email: Faker::Internet.unique.email, 
                       password: Faker::Internet.password
                      )
end

20.times do |n|
  events << Event.create(host: users.sample, 
                         title: Faker::Lorem.sentence(word_count: 4, random_words_to_add: 2),
                         location: Faker::Address.city,
                         description: Faker::Lorem.paragraph(sentence_count: 12),
                         start_time: Faker::Time.between(from: Time.zone.now + 2.days, to: Time.zone.now + 10.days)
                        )
end

# invite random sample of users to each event
events.each_with_index do |event, event_index|
  # sample a random user as host
  host = users.sample
  # e.g., [user_1, user_5, user_12, user7]
  # don't invite host to their own event
  users_sample = users.sample(4).reject { |u| u == host }
  users_sample.each_with_index do |user, user_index|
    invitation = Invitation.create(host: host, invitee: user, event: event)
    # semi-random assignment of rsvps
    invitation.update_attribute(:attending, 'yes') if event_index.even? && user_index.odd?
  end
end