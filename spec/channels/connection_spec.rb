require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do

  subject(:user) { create(:user) }

  context 'user is logged in' do
    it 'successfully connects' do
      log_in(user)
      connect
      expect(connection.current_user).to eq(user)
    end
  end

  context 'user is not logged in' do
    it 'does not connect' do
      expect { connect }.to have_rejected_connection
    end
  end
end
