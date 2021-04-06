class Event < ApplicationRecord
  belongs_to :host, class_name: "User"

  has_many :invitations, foreign_key: "event_id"

  has_many :invitees, through: :invitations,
                      class_name: "User"
end
