class User < ApplicationRecord
  has_secure_password

  belongs_to :role
  has_many :events
  has_many :registrations

  validates :email, presence: true, uniqueness: true
end
