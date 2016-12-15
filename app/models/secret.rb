class Secret < ApplicationRecord
  belongs_to :user
  has_many :users_likes, through: :likes, source: :user
  has_many :likes
  validates :secret, presence: true, length: {minimum: 4}
end
