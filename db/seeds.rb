users = []
events = []

# default login for people to try site
users << User.create(name: 'Foo Bar',
                     email: 'foo@bar.com',
                     password: 'foobar'
)

12.times do
  name_options = [Faker::Movies::LordOfTheRings.character, Faker::Movies::Lebowski.character, Faker::TvShows::Simpsons.character, Faker::TvShows::DumbAndDumber.character]
  users << User.create(name: name_options.sample, 
                       email: Faker::Internet.unique.email, 
                       password: Faker::Internet.password
                      )
end

36.times do
  title_options = ["#{Faker::Music.instrument} course", "#{Faker::Music.band} concert", "#{Faker::Music.album} listening party"]
  location_options = [Faker::Movies::LordOfTheRings.location, Faker::TvShows::Simpsons.location, Faker::Address.city]
  description_options = [Faker::TvShows::Simpsons.quote, Faker::TvShows::DumbAndDumber.quote, Faker::Quotes::Shakespeare.hamlet_quote]
  events << Event.create(host: users.sample, 
                         title: title_options.sample,
                         location: location_options.sample,
                         description: description_options.sample,
                         start_time: Faker::Time.between(from: Time.zone.now + 30.days, to: Time.zone.now + 500.days)
                        )
end

# invite random sample of users to each event
events.each_with_index do |event, event_index|
  host = event.host
  # e.g., [user_1, user_5, user_12, user7]
  # don't invite host to their own event
  users_sample = users.sample(7) - [host]
  users_sample.each_with_index do |user, user_index|
    invitation = Invitation.create(host: host, invitee: user, event: event)
    # semi-random assignment of rsvps
    invitation.update_attribute(:attending, 'yes') if event_index.even? && user_index.odd?
  end
end