class Api::V1::QuestionsController < Api::V1::BasesController
  def index
    questions = Question.includes(:user).all
    render json: questions, each_serializer: QuestionSerializer
  end

  def create
    question = @current_user.questions.new(question_params)

    if question.save
      render json: question, status: :created, serializer: QuestionSerializer
    else
      render json: { errors: question.errors.full_messages }, status: :unprocessable_entity
    end
  end

  def count_all_questions
    all_count = Question.count
    render json: { count: all_count }
  end

  private

  def question_params
    params.require(:question).permit(:uuid, :title, :body, :status)
  end
end
