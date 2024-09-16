# frozen_string_literal: true

class UserSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :github_uid, :profile, :avatar, :term
  has_many :questions, serializer: QuestionSerializer
  has_many :learned_tags, serializer: TagSerializer
  has_many :learning_tags, serializer: TagSerializer

  def avatar
    if Rails.env.development?
      "http://localhost:3000#{object.avatar.url}"
    else
      object.avatar.url
    end
  end

  def term
    object.term&.name
  end
end
