require "rails_helper"

RSpec.describe EventMailer, type: :mailer do
  describe "cancelation_email" do
    let(:event) { create(:event) }
    let(:first_invitee) { create(:user) }
    let(:second_invitee) { create(:user) }
    let(:first_invitation) { create(:invitation, event: event, host: event.host, invitee: first_invitee) }
    let(:second_invitation) { create(:invitation, event: event, host: event.host, invitee: second_invitee) }
    let(:mail) { EventMailer.with(event: event).cancelation_email }
    let(:url) { "localhost:3000/users/#{event.host.id}"}

    it "renders the subject" do
      expect(mail.subject).to eq("Event Cancelation Notice")
    end

    it "renders the recipients emails" do
      expect(mail.to).to eq(event.invitees.pluck(:email))
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["joe.mccann.dev@gmail.com"])
    end

    it "includes a link to the canceler's Private Events page" do
      expect(mail.body.encoded).to include(url)
    end

    it "includes the host's name" do
      expect(mail.body.encoded).to include(event.host.name)
    end

    it "includes the event title" do
      expect(mail.body.encoded).to include(event.title)
    end
  end
end
