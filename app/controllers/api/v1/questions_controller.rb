# frozen_string_literal: true

include Pagy::Backend

module Api
  module V1
    class QuestionsController < Api::V1::BasesController
      def index
        current_page = params[:page] || 1
        order_by = params[:order] || 'new'
        order_by = order_by == 'new' ? 'desc' : 'asc'
        _, questions = pagy(Question.includes(:user).all.order("created_at #{order_by}"), items: 10,
                                                                                          page: current_page)
        render json: questions, each_serializer: QuestionSerializer
      end

      def create
        question_params_without_tags = question_params.except(:tags)
        question = @current_user.questions.new(question_params_without_tags)

        # TODO: tagsを保存する処理を追加する

        if question.save
          render json: { uuid: question.uuid }, status: :created
        else
          render json: { message: question.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def count_all_questions
        all_count = Question.count
        render json: { count: all_count }
      end

      def ai_review
        title = question_params[:title]
        body = question_params[:body]
        tags = question_params[:tags]
        begin
          review = Chatgpt.call(title, tags, body)
          render json: { review: }, status: :ok
        rescue Net::ReadTimeout
          render json: { review: 'AIのレビューがタイムアウトしました。' }, status: :gateway_timeout
        end
      end

      private

      def question_params
        params.require(:question).permit(:uuid, :title, :body, :status, tags: [])
      end
    end
  end
end
