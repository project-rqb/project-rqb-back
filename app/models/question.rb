class Question < ApplicationRecord
  before_create :set_uuid
  belongs_to :user

  validates :uuid, presence: true, uniqueness: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true
  validates :status, presence: true

  enum status: { open: 0, close: 1 }

  def short_uuid
    Base64.urlsafe_encode64([uuid.delete('-')].pack("H*")).tr('=', '')
  end

  private

  def set_uuid
    self.uuid = SecureRandom.uuid
  end
end
