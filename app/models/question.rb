class Question < ApplicationRecord
  include UuidSetter
  before_validation :set_uuid, on: :create

  belongs_to :user

  has_many :answers, dependent: :destroy
  has_many :question_tags
  has_many :tags, through: :question_tags

  validates :uuid, presence: true, uniqueness: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true
  validates :status, presence: true

  enum status: { open: 0, close: 1 }

  scope :search, ->(query) do
    return all if query.blank?

    word = query.split(/[\s,、]+/).map(&:strip).reject(&:empty?)
    word.inject(all) do |result, string|
      result.where("title LIKE ? OR body LIKE ?", "%#{string}%", "%#{string}%")
    end
  end

  scope :filter_by_tag, ->(tag) do
    return all if tag.blank?
    joins(:tags).where(tags: { name: tag }).distinct
  end

  def add_tags(tags)
    return if tags.blank?

    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      self.tags << tag
    end
  end

  def update_tags(tags)
    return if tags.blank?

    self.tags.clear
    add_tags(tags)
  end
end
