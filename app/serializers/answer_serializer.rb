# frozen_string_literal: true

# Serializer for the Answer model
class AnswerSerializer < ActiveModel::Serializer
  attributes :id, :body, :created_at, :updated_at
  belongs_to :question
  belongs_to :user
end
