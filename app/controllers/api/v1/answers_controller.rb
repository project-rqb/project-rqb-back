# frozen_string_literal: true

# This controller handles the creation of answers associated with a question
class Api::V1::AnswersController < Api::V1::BasesController
  def create
    question = Question.find(params[:question_id])
    answer = question.answers.build(answer_params)
    answer.user = @current_user

    if @answer.save
      render json: answer, status: :created, serializer: AnswerSerializer
    else
      render json: answer.errors, status: :unprocessable_entity, serializer: AnswerSerializer
    end
  end

  private

  def answer_params
    params.require(:answer).permit(:body)
  end
end
