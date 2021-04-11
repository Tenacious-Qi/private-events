class Invitation < ApplicationRecord
  belongs_to :host, class_name: "User"
  belongs_to :event
  belongs_to :invitee, class_name: "User"
  
  # prevent sending a duplicate invitation to a user for the same event
  validates_uniqueness_of :invitee_id, scope: 'event_id'
end
