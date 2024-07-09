class Api::V1::SessionsController < ApplicationController
  skip_before_action :authenticate, only: [:create]

  def create
    user_info = request.env['omniauth.auth']
    raise 'GitHub情報の取得に失敗しました' unless user_info

    uid_info = user_info['uid']
    provider_info = user_info['provider']
    github_uid_info = user_info['info']['nickname']
    token_info = encode_access_token(uid_info)

    user_auth = User.find_by(uid: uid_info)
    User.create(uid: uid_info, provider: provider_info, github_uid: github_uid_info) unless user_auth

    redirect_to "#{ENV['FRONT_URL']}/auth?token=#{token_info}", allow_other_host: true
  rescue StandardError => e
    Rails.logger.error("認証エラー: #{e.message}")
    redirect_to "#{ENV['FRONT_URL']}?error=authentication_failed"
  end
end
