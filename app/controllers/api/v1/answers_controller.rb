# frozen_string_literal: true

# This controller handles the creation of answers associated with a question
class Api::V1::AnswersController < Api::V1::BasesController
  def index
    question = Question.find_by!(uuid: params[:question_id])

    answers = question.answers
    render json: answers, each_serializer: AnswerSerializer
  end

  def create
    question = Question.find_by!(uuid: params[:question_id])
    answer = question.answers.new(answer_params)
    answer.user = @current_user

    if answer.save
      render json: answer, status: :created, serializer: AnswerSerializer
    else
      render json: { errors: answer.errors.full_messages }, status: :unprocessable_entity
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
