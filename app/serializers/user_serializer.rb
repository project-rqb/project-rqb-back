class UserSerializer < ActiveModel::Serializer
  attributes :uid, :name
  has_many :questions, serializer: QuestionSerializer
end
