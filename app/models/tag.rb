# frozen_string_literal: true

class Tag < ApplicationRecord
  has_many :question_tags
  has_many :questions, through: :question_tags
  has_many :user_learning_tags
  has_many :learning_users, through: :user_learning_tags, source: :user
  has_many :user_learned_tags
  has_many :learned_users, through: :user_learned_tags, source: :user

  validates :name, presence: true, uniqueness: true, length: { maximum: 30, message: 'は最大30文字までです' },
                   format: { with: /\A[a-zA-Z0-9\-_. ]+\z/, message: 'はアルファベット、半角数字、-、_、.、および空白のみ使用できます。' }
end
