require 'rails_helper'

RSpec.feature "Events", type: :feature do
  describe "Editing an existing event" do
    subject(:user) { create(:user) }
    subject(:event) { create(:event, host: user) }

    context "A user tries to edit an event" do
      it "Shows them the edit user form" do
        visit login_path
        fill_in :session_email, with: user.email
        fill_in :session_password, with: user.password
        click_on "Log In"
        visit edit_event_path(event)
        expect(page).to have_content("Edit Event Info")
      end
    end
  end
end
