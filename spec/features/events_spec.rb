require 'rails_helper'

RSpec.feature "Events", type: :feature do
  describe "Editing an existing event" do
    subject(:user) { create(:user) }
    subject(:event) { create(:event, host: user) }

    before(:each) do
      visit login_path
      fill_in :session_email, with: user.email
      fill_in :session_password, with: user.password
      click_on "Log In"
    end

    context "A user tries to edit an event" do
      it "Shows them the edit user form" do
        visit edit_event_path(event)
        expect(page).to have_content("Edit Event Info")
      end
    end

    context "A user cancels an event" do
      let(:invitee_1) { create(:user) }
      let(:invitee_2) { create(:user) }
      let(:invitation_1) { create(:invitation, event: event, host: user, invitee: invitee_1) }
      let(:invitation_2) { create(:invitation, event: event, host: user, invitee: invitee_2) }

      it "sends invitees an email" do
        visit event_path(event)
        invitees_count = event.invitees.length
        expect { click_on "Cancel Event" }.to change { ActionMailer::Base.deliveries.count }.by(invitees_count)
      end
    end
  end
end
