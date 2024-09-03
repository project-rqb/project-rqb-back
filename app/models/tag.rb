class Tag < ApplicationRecord
  has_many :user_learning_tags
  has_many :learning_users, through: :user_learning_tags, source: :user
  has_many :user_learned_tags
  has_many :learned_users, through: :user_learned_tags, source: :user

  validates :name, presence: true, uniqueness: true
end
