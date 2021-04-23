require 'rails_helper'

RSpec.describe Event, type: :model do

  describe 'Validations' do
    
    subject { create(:event) }

    it 'has valid attributes' do
      expect(subject).to be_valid
    end

    it 'fails validations without a host' do
      event2 = build(:event, host: nil)
      expect(event2).to_not be_valid
    end

    it 'fails validations without a title' do
      event2 = build(:event, title: nil)
      expect(event2).to_not be_valid
    end

    it 'fails validations with too short a title' do
      event2 = build(:event, title: 'Ab')
      expect(event2).to_not be_valid
    end

    it 'fails validations with too long a title' do
      event2 = build(:event, title: 'A'*101)
      expect(event2).to_not be_valid
    end

    it 'fails validations without a start_time' do
      event2 = build(:event, start_time: nil)
      expect(event2).to_not be_valid
    end

    it 'fails validations when start_time is in past' do
      event2 = build(:event, start_time: Time.zone.now - 1.day)
      expect(event2).to_not be_valid
    end

    it 'fails validations without a location' do
      event2 = build(:event, location: nil)
      expect(event2).to_not be_valid
    end

    it 'fails validations with too short a location' do
      event2 = build(:event, location: 'aa')
      expect(event2).to_not be_valid
    end

    it 'fails validations with too long a location' do
      event2 = build(:event, location: 'a'*31)
      expect(event2).to_not be_valid
    end

    it 'passes validations without a description' do
      event2 = build(:event, description: nil)
      expect(event2).to be_valid
    end

    it 'fails validations with too short a description' do
      event2 = build(:event, description: 'aa')
      expect(event2).to_not be_valid
    end

    it 'fails validations with too long a description' do
      event2 = build(:event, description: 'a'*501)
      expect(event2).to_not be_valid
    end
  end

  describe 'Associations' do 

    subject { create(:event) }
    
    it { should belong_to(:host) }
    it { should have_many(:invitations) }
    it { should have_many(:invitees).through(:invitations) } 
  end
end