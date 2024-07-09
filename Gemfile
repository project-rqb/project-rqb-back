source "https://rubygems.org"

ruby "3.2.2"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"
gem "pg", "~> 1.1"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
  gem 'rubocop', require: false
end

# フロントとの通信を許可するためのgem
gem "rack-cors"

# 環境変数を管理するためのgem
gem 'dotenv-rails'

# 認証機能を実装するためのgem
gem 'omniauth'
gem 'omniauth-rails_csrf_protection'
gem 'omniauth-github', '~> 2.0.0'

# tokenを生成するためのgem
gem 'jwt'

gem "dockerfile-rails", ">= 1.6", :group => :development
