class User < ApplicationRecord
  include UuidSetter
  before_create :set_uuid

  has_many :questions
  has_many :answers

  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :github_uid, presence: true, uniqueness: true
end
