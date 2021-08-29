require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_email" do
    let(:user) { create(:user) }
    let(:home_page) { root_url }
    let(:user_show) { user_url(user) }
    let(:mail) { UserMailer.with(user: user).welcome_email }

    it "renders the subject" do
      expect(mail.subject).to eq("Welcome to Private Events.")
    end

    it "renders the recipient email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["joe.mccann.dev@gmail.com"])
    end

    it "includes a url to the home page" do
      expect(mail.body.encoded).to include(home_page)
    end

    it "includes a url to users#show" do
      expect(mail.body.encoded).to include(user_show)
    end

    it "includes the user's name" do
      expect(mail.body.encoded).to include(user.name)
    end
  end
end
