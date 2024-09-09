class QuestionTag < ApplicationRecord
  belongs_to :question
  belongs_to :tag

  validates :question_id, uniqueness: { scope: :tag_id }
  validates :name, length: { maximum: 30, message: 'は最大30文字までです' }
  validates :name, format: { with: /\A[a-z0-9]+\z/, message: 'は小文字のアルファベットと数字のみ使用できます' }
end
