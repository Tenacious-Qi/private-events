class Message < ApplicationRecord
  belongs_to :user
  # event_id optional for messages sent in member-chat
  belongs_to :event, optional: true

  validates :body, length: { in: 1..5000 }

  scope :non_event, -> { where(event_id: nil) }
end
