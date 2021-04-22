require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Validations' do

    subject { create(:user) }
    
    it 'has valid attributes' do
      expect(subject).to be_valid
    end

    it 'fails validation without an email' do
      user2 = build(:user, email: nil)
    end

    it 'fails validation if email already taken' do
      user2 = build(:user, email: subject.email )
      expect(user2).to_not be_valid
    end

    it 'fails validation if email is an invalid format' do
      user2 = build(:user, email: 'foo@bar')
      expect(user2).to_not be_valid
    end

    it 'has a secure password' do
      expect(subject).to have_secure_password
    end

    it 'fails validation without a password' do
      user2 = build(:user, password: nil)
      expect(user2).to_not be_valid
    end

    it 'fails validation with too short a password' do
      user2 = build(:user, password: 'short')
      expect(user2).to_not be_valid
    end

    it 'fails validation without a name' do
      user2 = build(:user, name: nil)
      expect(user2).to_not be_valid
    end

    it 'fails validation with too short a name' do
      user2 = build(:user, name: 'A')
      expect(user2).to_not be_valid
    end

    it 'fails validation with too long a name' do
      user2 = build(:user, name: 'A'*51)
      expect(user2).to_not be_valid
    end

    context 'before a user is saved' do
      it 'generates an auth_token' do
        user2 = build(:user)
        expect{ user2.save }.to change{ user2.auth_token }
      end
    end

  end
end

describe 'Associations' do

  subject { create(:user) }
  
  it { should have_many(:hosted_events) }
  it { should have_many(:received_invitations) }
  it { should have_many(:sent_invitations) }
  it { should have_many(:invited_events).through(:received_invitations) } 
end
