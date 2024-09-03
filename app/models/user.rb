class User < ApplicationRecord
  include UuidSetter
  before_create :set_uuid

  has_many :questions
  has_many :answers

  has_many :user_learning_tags
  has_many :learning_tags, through: :user_learning_tags, source: :tag

  has_many :user_learned_tags
  has_many :learned_tags, through: :user_learned_tags, source: :tag

  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :github_uid, presence: true, uniqueness: true
end
