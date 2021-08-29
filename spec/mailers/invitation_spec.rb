require "rails_helper"

RSpec.describe InvitationMailer, type: :mailer do
  describe "invitation_email" do
    let(:host) { create(:user) }
    let(:invitee) { create(:user) }
    let(:event) { create(:event, host: host) }
    let(:invitation) { create(:invitation, host: host, invitee: invitee, event: event )}
    let(:mail) { InvitationMailer.with(invitation: invitation).invitation_email }
    let(:url) { "localhost:3000/events/#{event.id}"}

    it "renders the subject" do
      expect(mail.subject).to eq("New Private Events Invitation")
    end

    it "renders the recipient email" do
      expect(mail.to).to eq([invitation.invitee.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["joe.mccann.dev@gmail.com"])
    end

    it "includes a url to the event page" do
      expect(mail.body.encoded).to include(url)
    end

    it "includes the event title" do
      expect(mail.body.encoded).to include(invitation.event.title)
    end

    it "includes the host's name" do
      expect(mail.body.encoded).to include(invitation.host.name)
    end
  end

  describe "uninvite_email" do
    let(:host) { create(:user) }
    let(:invitee) { create(:user) }
    let(:event) { create(:event, host: host) }
    let(:invitation) { create(:invitation, host: host, invitee: invitee, event: event )}
    let(:mail) { InvitationMailer.with(invitation: invitation).uninvite_email }
    let(:url) { "http://localhost:3000/events/users/#{invitee.id}"}

    it "renders the subject" do
      expect(mail.subject).to eq("You have been uninvited from an event")
    end

    it "renders the recipient email" do
      expect(mail.to).to eq([invitation.invitee.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["joe.mccann.dev@gmail.com"])
    end

    it "includes the event title" do
      expect(mail.body.encoded).to include(invitation.event.title)
    end

    it "includes the host's name" do
      expect(mail.body.encoded).to include(invitation.host.name)
    end
  end
end
