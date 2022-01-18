class User < ApplicationRecord
  before_save :downcase_email
  attr_accessor :remember_token

  before_save { self.email = email.downcase }

  has_many :orders
  has_secure_password

  validates :email, :password, presence: true
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  validates :email,
    format: { with: VALID_EMAIL_REGEX, message: "Email invalid"  },
    uniqueness: { case_sensitive: false },
    length: { minimum: 4, maximum: 50 }

  validates :password, length: { minimum: 4, maximum: 20}

  class << self
    def digest(string)
      cost = ActiveModel::SecurePassword.min_cost ? BCrypt::Engine::MIN_COST :
      BCrypt::Engine.cost
      BCrypt::Password.create(string, cost: cost)
    end
  
    def new_token
      SecureRandom.urlsafe_base64
    end
  end
  
  def remember
    self.remember_token = User.new_token
    update_attribute(:remember_digest, User.digest(remember_token))
  end

  def aunthenticated?(remember_token)
    return false if remember_digest.nil?
    BCrypt::Password.new(:remember_digest).is_password?(remember_token)
  end

  def forget
    update_attribute(:remember_digest, nil)
  end

  private
  def downcase_email
    self.email = email.downcase
  end

end
