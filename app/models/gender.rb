class Gender < ApplicationRecord
  validates :name, presence: true, uniqueness: true
  has_many :sneakers
end
