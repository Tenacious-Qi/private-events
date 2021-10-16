require 'rails_helper'

RSpec.describe ApplicationCable::Connection, type: :channel do

  subject(:user) { create(:user) }

  it 'successfully connects' do
    log_in(user)
    connect '/'
    expect(connection.current_user).to eq(user)
  end
end
