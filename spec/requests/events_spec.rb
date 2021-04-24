require 'rails_helper'

RSpec.describe Event, type: :request do

  subject(:event) { create(:event) }
  subject(:user)  { create(:user) }

  # login before event actions
  before :each do
    login(user)
  end

  describe 'GET events#new' do
    it 'should get the new event page' do
      get new_event_path
      expect(response).to have_http_status(200)
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
  end

  describe 'GET events#index' do
    it 'should get the events index page' do
      get events_path
      expect(response).to have_http_status(200)
    end
  end

  describe 'GET events#show' do
    it 'should get the page of a single event' do
      get event_path(event)
      expect(response).to have_http_status(200)
    end
  end
end
