require 'rails_helper'

RSpec.describe "Invitations", type: :request do

  subject(:invite) { create(:invitation) }

  describe "PUT invitations#update" do
    it "redirects to login_path if not logged in" do
      put "/invitations/#{invite.id}", params: { invitation: attributes_for(:invitation) }
      expect(response).to redirect_to(login_path)
    end
  end

  describe "POST invitations#create" do
    it "redirects to login_path if not logged in" do
      put "/invitations/#{invite.id}", params: { invitation: attributes_for(:invitation) }
      expect(response).to redirect_to(login_path)
    end
  end

  describe "DELETE invitations#destroy" do
    it "redirects to login_path if not logged in" do
      delete "/invitations/#{invite.id}", params: { invitation: attributes_for(:invitation) }
      expect(response).to redirect_to(login_path)
    end
  end

end
