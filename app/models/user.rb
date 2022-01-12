class User < ApplicationRecord
  has_secure_password
  validates :email, :password, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
    format: { with: VALID_EMAIL_REGEX, message: "Email invalid"  },
    uniqueness: { case_sensitive: false },
    length: { minimum: 4, maximum: 50 }

  validates :password, length: { minimum: 4, maximum: 20}
end
