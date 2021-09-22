require 'rails_helper'

RSpec.describe "Invitations", type: :request do

  subject(:invite) { create(:invitation) }

  describe "PUT invitations#update" do
    it "redirects to login_path if not logged in" do
      put "/invitations/#{invite.id}", params: { invitation: attributes_for(:invitation) }
      expect(response).to redirect_to(login_path)
    end

    it "updates the invitation if logged in" do
      headers = { "ACCEPT" => "application/json" }
      host = create(:user)
      invitee = create(:user)
      login(invitee)
      event = create(:event, host: host)
      
      invitation = host.sent_invitations.build(host: host, event: event, invitee: invitee)
      invitation.save
  
      put "/invitations/#{invitation.id}", params: { invitation: { attending: 'yes' }  }, :headers => headers
      # expect(response.content_type).to eq("application/json; charset=utf-8")
      # see https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/PUT => 200 is an ok response. It means the resource exists and was updated
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST invitations#create" do
    it "redirects to login_path if not logged in" do
      post "/invitations/", params: { invitation: attributes_for(:invitation) }
      expect(response).to redirect_to(login_path)
    end

    it "allows invitation creation for logged in users" do
      
      host = create(:user)
      # fails (as it should) when login helper is commented out
      login(host)
      invitee = create(:user)
      event = create(:event, host: host)
      invitation = host.sent_invitations.build(host: host, event: event, invitee: invitee)
      post "/invitations/", params: { invitation: { recipient_ids: [invitee.id], host: invitation.host, event_id: invitation.event.id, invitee: invitation.invitee} }
      # status is not :created or 201 because it is an XHR request (asynchronous) ?
      # redirects to event if format is html
      expect(response).to redirect_to(event)
    end
  end

  describe "DELETE invitations#destroy" do
    it "redirects to login_path if not logged in" do
      delete "/invitations/#{invite.id}", params: { invitation: attributes_for(:invitation) }
      expect(response).to redirect_to(login_path)
    end
  end

end
