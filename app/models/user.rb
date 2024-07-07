class User < ApplicationRecord
  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :github_uid, presence: true, uniqueness: true
end
