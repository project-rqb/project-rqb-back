source "https://rubygems.org"

ruby "3.2.3"
gem "rails", "~> 7.1.3", ">= 7.1.3.4"
gem "mysql2", "~> 0.5"
gem "puma", ">= 5.0"
gem "tzinfo-data", platforms: %i[ windows jruby ]
gem "bootsnap", require: false

group :development, :test do
  gem "debug", platforms: %i[ mri windows ]
end

group :development do
end

# CORS対策
gem "rack-cors"
# 環境変数管理
gem "dotenv-rails"