class User < ApplicationRecord
  has_secure_password
  validates :email, presence: true, length: { minimum: 6 }
  validates :first_name, presence: true, length: { minimum: 3 }
  validates :last_name, presence: true, length: { minimum: 2 }
  validates :password, presence: true, length: { minimum: 6 }

  belongs_to :city
  has_many :gossips
  has_many :comments
end
