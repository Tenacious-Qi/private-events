require 'rails_helper'

RSpec.describe Event, type: :request do

  
  subject(:user)  { create(:user) }
  subject(:event) { create(:event, host: user) }
  subject(:non_hosted_event) { create(:event) }

  # login before event actions
  before :each do
    login(user)
  end

  describe 'GET events#new' do
    it 'should get the new event page' do
      get new_event_path
      expect(response).to have_http_status(:success)
    end

    it 'should redirect if not logged in' do
      delete logout_path
      get new_event_path
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'POST events#create' do
    it 'should redirect if not logged in' do
      delete logout_path
      get new_event_path
      post "/events", params: { event: attributes_for(:event) }
      expect(response).to redirect_to(login_path)
    end

    it 'should redirect to event page after creating a record' do
      get new_event_path
      post "/events", params: { event: attributes_for(:event) }
      expect(response).to have_http_status(:redirect)
    end

    it 'should load the new event form if event creation fails (missing required params)' do
      event = create(:event)
      get new_event_path
      post "/events", params: { event: attributes_for(:event, title: nil)}
      warning_message = flash[:warning] = "Event creation failed. Please try again."
      expect(warning_message).to be_present
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET events#index' do
    it 'should get the events index page' do
      get events_path
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET events#show' do
    it 'should get the page of a single event' do
      get event_path(event)
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET events#edit' do
    it 'should get the edit page of a single event' do
      get edit_event_path(event)
      expect(response).to have_http_status(:success)
    end

    it 'should redirect to login path if not logged in' do
      delete logout_path
      get edit_event_path(event)
      expect(response).to redirect_to(login_path)
    end

    it 'should redirect to event path if event does not belong to current user' do
      get edit_event_path(non_hosted_event)
      expect(response).to redirect_to(event_path(non_hosted_event))
    end
  end
end
