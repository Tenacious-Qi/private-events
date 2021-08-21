class Invitation < ApplicationRecord
  belongs_to :host, class_name: "User"
  belongs_to :event
  belongs_to :invitee, class_name: "User"
  
  # prevent sending a duplicate invitation to a user for the same event
  validates_uniqueness_of :invitee_id, scope: 'event_id'
  validate :host_cannot_invite_self

  scope :rsvp_yes_past, -> { joins(:event).where("attending = ? AND start_time < ?", 'yes', Time.zone.now) }
  scope :rsvp_yes_future, -> { joins(:event).where("attending = ? AND start_time > ?", 'yes', Time.zone.now) }
  scope :rsvp_pending, -> { joins(:event).where("attending = ? AND start_time > ?", 'no response', Time.zone.now) }

  private

  def host_cannot_invite_self
    errors.add(:invitation, 'host cannot invite themselves') if host == invitee
  end
end
