class Question < ApplicationRecord
  include UuidSetter
  before_validation :set_uuid, on: :create

  belongs_to :user

  has_many :answers, dependent: :destroy

  validates :uuid, presence: true, uniqueness: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true
  validates :status, presence: true

  enum status: { open: 0, close: 1 }
end
