require 'rails_helper'

# in routes.rb . . .

# get    '/login',  to: 'sessions#new'
# post   '/login',  to: 'sessions#create'

RSpec.describe "Sessions", type: :request do
  describe "GET sessions#new" do
    it "gets the login page" do
      get "/login"
      expect(response).to have_http_status(200)
    end
  end

  describe "POST sessions#create" do
    it "creates a session and then redirects to events#index (root)" do
      user = create(:user)
      post login_path, params: { session: { email: user.email, password: user.password } }
      expect(response).to redirect_to(root_url)
    end

    context "incorrect email or password login attempt" do
      it "informs you of incorrect email or password if password is incorrect" do
        user = create(:user, password: 'the correct password')
        post login_path, params: { session: { email: user.email, password: 'hey.this.is.wrong.password' } }
        expect(flash[:warning] = 'Incorrect email or password').to be_present
        expect(response).to have_http_status(200)
      end

      it "fails if email is not included in parameters posted to login_path" do
        user = create(:user)
        post login_path, params: { session: { email: nil, password: user.password } }
        expect(flash[:warning] = 'Incorrect email or password').to be_present
        expect(response).to have_http_status(200)
      end

      it "fails if password is not included in parameters posted to login_path" do
        user = create(:user)
        post login_path, params: { session: { email: user.email, password: nil } }
        expect(flash[:warning] = 'Incorrect email or password').to be_present
        expect(response).to have_http_status(200)
      end

      it "fails if neither email nor password are present" do
        post login_path, params: { session: { email: nil, password: nil } }
        expect(flash[:warning] = 'Incorrect email or password').to be_present
        expect(response).to have_http_status(200)
      end
    end 
  end

  describe "GET sessions#new" do
    it "redirects a logged in user to their own users#show page" do
      user = create(:user)
      login(user)
      get login_path
      expect(response).to redirect_to(user_path(user))
      expect(user.auth_token).to be_present
    end
  end

  describe "DELETE sessions#destroy" do
    it "informs user they have logged out" do
      user = create(:user)
      login(user)
      delete "/logout"
      expect(flash[:info] = 'You have logged out.').to be_present
    end

    it "redirects them to the login page" do
      user = create(:user)
      login(user)
      delete "/logout"
      expect(response).to redirect_to(login_path)
    end

    it "removes their auth_token from the cookies hash" do
      user = create(:user)
      login(user)
      user_token = user.auth_token
      expect(user_token).to_not be_nil
      expect(cookies[:auth_token]).to eq(user_token)
      delete "/logout"
      expect(cookies[:auth_token]).to be_empty
    end
  end
end
