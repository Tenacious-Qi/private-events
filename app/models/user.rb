class User < ApplicationRecord
  has_many :hosted_events, class_name: "Event",
                           foreign_key: "host_id"

  has_many :attended_events, through: :invitations, 
                             class_name: "Event",
                             source: :event
                             
  has_many :invitations, foreign_key: "attendee_id"
                             
  has_secure_password
  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, length: { maximum: 255 },
                                    format: { with: VALID_EMAIL_REGEX },
                                    uniqueness: true
  validates :password, length: { minimum: 6 }

  before_create { generate_token(:auth_token) }

  def generate_token(column)
    begin
      self[column] = SecureRandom.urlsafe_base64
    end while User.exists?(column => self[column])    
  end
end
