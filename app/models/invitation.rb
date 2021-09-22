class Invitation < ApplicationRecord
  belongs_to :host, class_name: "User"
  belongs_to :event
  belongs_to :invitee, class_name: "User"
  # for inviting more than one guest at a time
  has_many :recipients, class_name: "User"
  
  # prevent sending a duplicate invitation to a user for the same event
  validates_uniqueness_of :invitee_id, scope: 'event_id'
  validates_with SelfInvitePreventer

  scope :rsvp_yes_past, -> { joins(:event).where("attending = ? AND start_time < ?", 'yes', Time.zone.now) }
  scope :rsvp_yes_future, -> { joins(:event).where("attending = ? AND start_time > ?", 'yes', Time.zone.now) }
  scope :rsvp_pending, -> { joins(:event).where("attending = ? AND start_time > ?", 'no response', Time.zone.now) }
  scope :rsvp_attendance_canceled, -> { joins(:event).where("attending = ? AND start_time > ?", 'no', Time.zone.now) }
end
