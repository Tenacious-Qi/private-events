require 'rails_helper'

RSpec.describe Invitation, type: :model do

  describe 'Validations' do
    subject { create(:invitation) }

    it 'has valid attributes' do
      expect(subject).to be_valid
    end

    it 'fails validation if host missing' do
      invitation2 = build(:invitation, host: nil)
      expect(invitation2).to_not be_valid
    end

    it 'fails validation if event missing' do
      invitation2 = build(:invitation, event: nil)
      expect(invitation2).to_not be_valid
    end

    it 'fails validation if invitee missing' do
      invitation2 = build(:invitation, invitee: nil)
      expect(invitation2).to_not be_valid
    end

    it 'fails validations if invitation already sent to user for same event' do
      invitation2 = build(:invitation, event: subject.event, invitee: subject.invitee )
      expect(invitation2).to_not be_valid
    end

    it 'fails validation if user invites themselves' do
      host = create(:user)
      event = create(:event, host: host)
      invitation = build(:invitation, host: host, invitee: host, event: event)
      expect(invitation).to_not be_valid
    end
  end

  describe 'Associations' do
    subject { create(:invitation) }

    it { should belong_to(:event) }
    it { should belong_to(:host) }
    it { should belong_to(:invitee) }
  end
end
