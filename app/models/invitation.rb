class Invitation < ApplicationRecord
  belongs_to :host
  belongs_to :event
  belongs_to :attendee
end
