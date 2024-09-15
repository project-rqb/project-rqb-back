# frozen_string_literal: true

source 'https://rubygems.org'

ruby '3.2.2'
gem 'bootsnap', require: false
gem 'pg', '~> 1.1'
gem 'puma', '>= 5.0'
gem 'rails', '~> 7.1.3', '>= 7.1.3.4'
gem 'tzinfo-data', platforms: %i[windows jruby]

group :development, :test do
  gem 'debug', platforms: %i[mri windows]
end

group :development do
  gem 'rubocop', require: false
end

# フロントとの通信を許可するためのgem
gem 'rack-cors'

# 環境変数を管理するためのgem
gem 'dotenv-rails'

# 認証機能を実装するためのgem
gem 'omniauth'
gem 'omniauth-github', '~> 2.0.0'
gem 'omniauth-rails_csrf_protection'

# jsonデータ整形のためのgem
gem 'active_model_serializers'
# tokenを生成するためのgem
gem 'jwt'

gem 'dockerfile-rails', '>= 1.6', group: :development

# シリアライザーを実装するためのgem
gem 'active_model_serializers'

# ページネーション
gem 'pagy', '~> 9.0'

# リクエストを送信するためのgem
gem 'httparty'

# 画像アップローダー
gem 'carrierwave', '~> 3.0'
# base64形式の画像をアップロードするためのgem
gem 'carrierwave-base64'

# AWS S3に画像をアップロードするためのgem
gem 'fog-aws', group: :production

# 画像加工
gem 'image_processing', '~> 1.2'
gem 'mini_magick'
