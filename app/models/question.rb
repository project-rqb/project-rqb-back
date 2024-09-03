class Question < ApplicationRecord
  include UuidSetter
  before_create :set_uuid

  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :question_tags
  has_many :tags, through: :question_tags

  validates :uuid, presence: true, uniqueness: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true
  validates :status, presence: true

  enum status: { open: 0, close: 1 }
end
