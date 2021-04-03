class Invitation < ApplicationRecord
  belongs_to :host
  belongs_to :event
end
