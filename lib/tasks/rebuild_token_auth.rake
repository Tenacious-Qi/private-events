namespace :user do
  desc "Rebuild Auth-Tokens"
  task :rebuild_auth_token => :environment do
    User.transaction do
      User.all.each do |user|
        user.generate_token(:auth_token)
        user.save
      end
    end
  end
end