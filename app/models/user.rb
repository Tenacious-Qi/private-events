class User < ApplicationRecord
  has_many :hosted_events, class_name: "Event",
                           foreign_key: "host_id",
                           dependent: :destroy

  has_many :sent_invitations, class_name: "Invitation",
                              foreign_key: "host_id",
                              dependent: :destroy

  has_many :received_invitations, class_name: "Invitation",
                                  foreign_key: "invitee_id",
                                  dependent: :destroy

  has_many :invited_events,  through: :received_invitations, 
                             class_name: "Event",
                             foreign_key: "invitee_id",
                             source: :event,
                             dependent: :destroy

  has_many :messages, dependent: :destroy

  scope :inviteable, ->(event) { where.not(id: [event.host.id, event.invitees.map(&:id)].flatten ) }

  has_secure_password
  has_secure_token :auth_token

  validates :name, presence: true, length: { in: 2..50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: true
  validates :password, length: { minimum: 6 }

  def appear(data)
    self.update_columns(online: true, viewing: data[:on])
    ActionCable.server.broadcast 'appearance', { event: 'appear', user_id: self.id, viewing: self.viewing}
  end

  def disappear
    self.update_columns(online: false, viewing: nil)
    ActionCable.server.broadcast 'appearance', { event: 'disappear', user_id: self.id }
  end

  def away
    self.update_columns(online: true, viewing: nil)
    ActionCable.server.broadcast 'appearance', { event: 'away', user_id: self.id }
  end
end
