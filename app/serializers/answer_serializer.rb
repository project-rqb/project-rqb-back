# frozen_string_literal: true

# Serializer for the Answer model
class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at
  belongs_to :question
  belongs_to :user

  def created_at
    object.created_at.strftime('%Y/%m/%d %H:%M')
  end
end
