require 'rails_helper'

RSpec.feature "Forms", type: :feature do

  # subject(:new_event) { build(:event) }
  
  describe 'Signup process' do

    subject(:person) { build(:user) }

    context 'a new user wants to signup for private events' do
      it 'allows them to create an account' do
        visit '/signup'
        fill_in :user_name, with: person.name
        fill_in :user_email, with: person.email
        fill_in :user_password, with: person.password
        fill_in :user_password_confirmation, with: person.password
        click_on 'Create Account'
        expect(page).to have_content('Account successfully created')
      end
    end
  end

  describe 'Creating a new event' do
    # need a valid user to log in, thus the new subject
    subject(:person) { create(:user) }

    context 'a logged in user wants to create a new event' do
      it 'allows them to create an an event' do
        
        new_event = build(:event)

        visit login_path
        fill_in :session_email, with: person.email
        fill_in :session_password, with: person.password
        click_on 'Log In'

        visit '/events/new'
        
        fill_in :event_title, with: new_event.title
        fill_in :event_location, with: new_event.location
        fill_in :event_description, with: new_event.description
        fill_in :event_start_time, with: new_event.start_time

        click_on 'Create Event'
        expect(page).to have_content('Event created successfully')
      end
    end
  end

  describe 'Logging out' do
    # need a valid user to log out, thus the new subject
    subject(:person) { create(:user) }

    context 'a logged in user wants to create a new event' do
      it 'allows them to logout' do
        visit login_path
        fill_in :session_email, with: person.email
        fill_in :session_password, with: person.password
        click_on 'Log In'

        click_on 'Logout'
        expect(page).to have_content('You have logged out')
      end
    end
  end

  describe 'Inviting a guest' do
    
    context 'the host of an event wants to invite a guest' do

      it 'allows a host to select a guest, invite them, and finally uninvite them.', js: true do
        inviter = create(:host)

        visit login_path
        fill_in :session_email, with: inviter.email
        fill_in :session_password, with: inviter.password
        click_on 'Log In'
        
        invited_event = create(:event, host: inviter)
        invitee = create(:invitee)
        visit user_path(inviter)
        expect(page).to have_content(inviter.name)
        expect(page).to have_content(invited_event.title.capitalize)

        click_on invited_event.title
        expect(page).to have_current_path(event_path(invited_event))
        expect(page).to have_content('Select an invitee')
        
        select(invitee.name, from: "invitation_invitee_id")
        click_on('send-invitation')
        # name appears in invitees list after clicking 'send invitation'
        expect(page).to have_link(invitee.name)

        expect(page).to have_button('uninvite')
        page.accept_confirm { click_on 'uninvite' }

        # name no longer appears in invitees list after clicking 'uninvite'
        expect(page).to have_no_link(invitee.name)
        expect(page).to have_no_button('uninvite')
      end
    end
  end
end