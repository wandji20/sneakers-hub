class User < ApplicationRecord
  has_secure_password
  validates :email, :password, presence: true
  validates :email,
    format: { with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/, message: "Email invalid"  },
    uniqueness: { case_sensitive: false },
    length: { minimum: 4, maximum: 50 }

  validates :password, length: { minimum: 4, maximum: 20}
end
