class Api::V1::QuestionsController < Api::V1::BasesController
  def index
    questions = Question.includes(:user).all
    render json: questions, each_serializer: QuestionSerializer
  end
end
