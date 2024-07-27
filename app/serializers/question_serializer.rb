class QuestionSerializer < ActiveModel::Serializer
  attributes :uuid, :title, :body, :status
  belongs_to :user, serializer: UserSerializer
end
