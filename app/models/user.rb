# frozen_string_literal: true

class User < ApplicationRecord
  include UuidSetter
  before_create :set_uuid

  has_many :questions
  has_many :answers
  has_many :user_learning_tags
  has_many :learning_tags, through: :user_learning_tags, source: :tag
  has_many :user_learned_tags
  has_many :learned_tags, through: :user_learned_tags, source: :tag

  mount_base64_uploader :avatar, AvatarUploader, file_name: lambda(&:id)

  validates :uid, presence: true, uniqueness: true
  validates :provider, presence: true
  validates :github_uid, presence: true, uniqueness: true

  def add_learned_tags(tags)
    learned_tags.destroy_all

    return if tags[0].blank?

    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      learned_tags << tag
    end
  end

  def add_learning_tags(tags)
    learning_tags.destroy_all

    return if tags[0].blank?

    tags.each do |tag|
      tag = Tag.find_or_create_by(name: tag)
      learning_tags << tag
    end
  end
end
