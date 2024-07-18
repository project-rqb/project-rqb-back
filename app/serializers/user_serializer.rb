class UserSerializer < ActiveModel::Serializer
  attributes :name
  
  has_many :questions, serializer: QuestionSerializer
end
