class Message < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :body, length: { maximum: 500 }
end
