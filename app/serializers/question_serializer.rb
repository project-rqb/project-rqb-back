# frozen_string_literal: true

class QuestionSerializer < ActiveModel::Serializer
  attributes :uuid, :title, :body, :status, :created_at, :updated_at
  belongs_to :user, serializer: UserSerializer

  has_many :tags

  def created_at
    object.created_at.strftime('%Y/%m/%d %H:%M')
  end

  def updated_at
    object.updated_at.strftime('%Y/%m/%d %H:%M')
  end
end
