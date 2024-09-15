class Api::V1::UsersController < Api::V1::BasesController
  def show
    user = User.find_by(uuid: params[:id])
    if user.present?
      render json: user, serializer: UserSerializer, status: :ok
    else
      render json: { error: 'ユーザーが見つかりません' }, status: :not_found
    end
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

  private

  def user_params
    params.require(:user).permit(:name, :profile, :avatar, learned_tags: [], learning_tags: [])
  end
end
