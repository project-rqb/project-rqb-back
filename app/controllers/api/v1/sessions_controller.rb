class Api::V1::SessionsController < Api::V1::BasesController
  skip_before_action :authenticate, only: [:create]

  def create
    user_info = request.env['omniauth.auth']
    raise 'GitHub情報の取得に失敗しました' unless user_info

    user_uid = user_info['uid']
    user_provider = user_info['provider']
    user_github_uid = user_info['info']['nickname']
    encoded_token = encode_access_token(user_uid)

    existing_user = User.find_by(uid: user_uid)
    unless existing_user
      User.create(uid: user_uid, provider: user_provider, github_uid: user_github_uid,
                  name: user_github_uid)
    end

    redirect_to "#{ENV['FRONT_URL']}?token=#{encoded_token}", allow_other_host: true
  rescue StandardError => e
    Rails.logger.error("認証エラー: #{e.message}")
    redirect_to "#{ENV['FRONT_URL']}?error=authentication_failed"
  end

  def me
    render json: @current_user, serializer: UserSerializer
  end
end
