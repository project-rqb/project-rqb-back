# frozen_string_literal: true

include Pagy::Backend

module Api
  module V1
    class QuestionsController < Api::V1::BasesController
      def index
        current_page = params[:page] || 1
        pagy, questions = pagy(Question.includes(:user).all, page: current_page)
        render json: questions, each_serializer: QuestionSerializer
      end

      def create
        question = @current_user.questions.new(question_params)

        if question.save
          render json: { uuid: question.uuid }, status: :created
        else
          render json: { message: question.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def show
        question = Question.find_by(uuid: params[:id])
        render json: question, serializer: QuestionSerializer
      end

      def count_all_questions
        all_count = Question.count
        render json: { count: all_count }
      end

      def close
        question = Question.find_by!(uuid: params[:id])
        if question.update(status: 'close')
          render json: { status: question.status }, status: :ok
        else
          render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
        end
      end

      private

      def question_params
        params.require(:question).permit(:uuid, :title, :body, :status, :page)
      end
    end
  end
end
