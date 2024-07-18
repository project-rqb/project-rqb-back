class Api::V1::QuestionsController < ApplicationController
  def index
    questions = Question.includes(:user).all
    render json: questions, each_serializer: QuestionSerializer
  end
end
