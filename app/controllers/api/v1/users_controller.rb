# frozen_string_literal: true

module Api
  module V1
    class UsersController < Api::V1::BasesController
      include Pagy::Backend
      rescue_from ActiveRecord::RecordNotFound, with: :record_not_found

      def show
        user = User.find_by!(uuid: params[:id])
        render json: user, serializer: UserSerializer, status: :ok
      end

      def update
        @current_user.add_learned_tags(user_params[:learned_tags])
        @current_user.add_learning_tags(user_params[:learning_tags])
        user_params_without_tags = user_params.except(:learned_tags, :learning_tags)

        begin
          @current_user.update!(user_params_without_tags)
          render json: @current_user, serializer: UserSerializer, status: :ok
        rescue StandardError => e
          Rails.logger.error(e.message)
          render json: { error: e.message }, status: :bad_request
        end
      end

      def questions
        user = User.find_by!(uuid: params[:id])
        tab = params[:tab] || 'questions'
        current_page = params[:page] || 1
        _, questions = fetch_questions(user, tab, current_page)
        render json: questions, each_serializer: QuestionSerializer, status: :ok
      end

      def all_questions_count
        user = User.find_by!(uuid: params[:id])
        tab = params[:tab] || 'questions'
        all_count = tab == 'questions' ? user.questions.count : user.answers.count
        render json: { count: all_count }, status: :ok
      end

      private

      def user_params
        params.require(:user).permit(:name, :profile, :avatar, learned_tags: [], learning_tags: [])
      end

      def record_not_found
        render json: { error: 'ユーザーが見つかりません' }, status: :not_found
      end

      def fetch_questions(user, tab, current_page)
        if tab == 'questions'
          pagy(user.questions.order('created_at desc'), items: 10, page: current_page)
        else
          questions_relation = Question.joins(:answers).where(answers: { user_id: user.id }).order('questions.created_at desc')
          pagy(questions_relation, items: 10, page: current_page)
        end
      end
    end
  end
end
