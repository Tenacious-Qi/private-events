require 'rails_helper'

RSpec.feature "Users", type: :feature do
  describe "Editing a user account" do
    subject { create(:user) }

    context "A user tries to edit their own account" do
      it "Shows them the edit user form" do
        visit login_path
        fill_in :session_email, with: subject.email
        fill_in :session_password, with: subject.password
        click_on "Log In"
        click_on subject.name

        expect(page).to have_content("Edit Account Info")
      end
    end

    context "A user tries to edit another users account" do
      context "They manually navigate to '/users/edit/some_other_users_account'" do
        let(:other_user) { create(:user) }

        before(:each) do
          visit login_path
          fill_in :session_email, with: subject.email
          fill_in :session_password, with: subject.password
          click_on "Log In"
        end
        
        it "redirects them to root path" do
          visit edit_user_path(other_user)
          expect(current_path).to eq(root_path)
        end

        it "flashes a warning" do
          visit edit_user_path(other_user)
          expect(page).to have_content("You can only edit your own account!")
        end
      end
    end
  end
end
