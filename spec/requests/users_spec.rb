require 'rails_helper'

RSpec.describe "Users", type: :request do

  subject { create(:user) }
  
  describe 'GET users#new' do
    it 'should get signup page' do
      get '/users/new'
      expect(response).to have_http_status(:success)
    end
  end

  describe 'GET users#show' do
    it 'should get the users#show page' do
      # users#show page redirects to login_path unless logged in.
      post login_path, params: { session: { email: subject.email,
                                            password: subject.password } }
      get user_path(subject)
      expect(response).to have_http_status(:success)
    end

    it 'should redirect if not logged in' do
      get user_path(subject)
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'GET users#index' do
    it 'should get the users#index page' do
      post login_path, params: { session: { email: subject.email,
                                            password: subject.password } }
      get users_path
      expect(response).to have_http_status(:success)
    end

    it 'should redirect if not logged in' do
      get users_path
      expect(response).to redirect_to(login_path)
    end
  end

  describe 'POST users#create' do
    it 'redirect to root_url (events#index) after signing up a new user' do
      post users_path, params: { user: attributes_for(:user) }
      expect(response).to redirect_to(root_url)
    end
  end
end
