class Event < ApplicationRecord
  belongs_to :host, class_name: "User"

  has_many :attendees, through: :invitations,
                       class_name: "User",
                       source: :user

  has_many :invitations, foreign_key: "event_id"
end
