class Message < ApplicationRecord
  belongs_to :user
  belongs_to :event

  validates :body, length: { in: 5..500 }
end
