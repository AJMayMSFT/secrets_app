class User < ApplicationRecord
  has_secure_password
  has_many :secrets
  has_many :secrets_liked, through: :likes, source: :secret
  has_many :likes
  EMAIL_REGEX = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]+)\z/i
  validates :name, presence: true
  validates :email, presence: true, uniqueness: {case_sensitive: false}, format: {with: EMAIL_REGEX}
  validates :password, length: { minimum: 6 }
end
