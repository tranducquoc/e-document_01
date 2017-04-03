source "https://rubygems.org"

git_source(:github) do |repo_name|
  repo_name = "#{repo_name}/#{repo_name}" unless repo_name.include?("/")
  "https://github.com/#{repo_name}.git"
end
gem "rails", "~> 5.0.1"
gem "devise"
gem "carrierwave", "~> 1.0"
gem "mini_magick",  "4.5.1"
gem "fog"
gem "rubocop", require: false
gem "bootstrap-sass", "3.3.6"
gem "i18n-js", ">= 3.0.0.rc11"
gem "delayed_job"
gem "delayed_job_active_record"
gem "daemons"
gem "cancancan"
gem "paranoia", "~> 2.2"
gem "font-awesome-sass", "~> 4.7.0"
gem "puma", "~> 3.0"
gem "sass-rails", "~> 5.0"
gem "uglifier", ">= 1.3.0"
gem "coffee-rails", "~> 4.2"
gem "jquery-rails"
gem "turbolinks", "~> 5"
gem "jbuilder", "~> 2.5"
gem "config", "~> 1.0"
gem "ransack", "~> 1.7"
gem "kaminari"
gem "friendly_id", "~> 5.1.0"
gem "sidekiq", "~> 4.2", ">= 4.2.7"
gem "public_activity", "~> 1.5"
gem "social-share-button"
gem "omniauth-facebook"
gem "figaro"
gem "whenever", require: false
gem "rmagick", "~> 2.15", ">= 2.15.4"
gem "simple_form"
gem "select2-rails"
gem "bootbox-rails", "~>0.4"
gem "database_yml"

group :development, :test do
  gem "byebug", platform: :mri
  gem "rspec-rails", "~> 3.5"
  gem "shoulda-matchers", "~> 3.1"
  gem "database_cleaner"
  gem "capybara"
  gem "factory_girl_rails"
  gem "ffaker"
  gem "rails-controller-testing"
  gem "simplecov", require: false
  gem "sqlite3"
end

group :development do
  gem "web-console", ">= 3.3.0"
  gem "listen", "~> 3.0.5"
  gem "spring"
  gem "spring-watcher-listen", "~> 2.0.0"
end

group :production do
  # gem "pg"
  gem "mysql2"
end

gem "tzinfo-data", platforms: [:mingw, :mswin, :x64_mingw, :jruby]
