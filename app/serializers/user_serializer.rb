class UserSerializer < ActiveModel::Serializer
  attributes :uuid, :name, :github_uid, :profile
  has_many :questions, serializer: QuestionSerializer
end
