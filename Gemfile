source 'https://rubygems.org'

gem 'rails', '4.2.6'
gem 'rails-api'
gem 'spring', :group => :development
gem 'pg'
gem 'bcrypt'
gem 'active_model_serializers', '~> 0.10.0'

group :development do
  gem 'guard-rspec', require: false
end

group :development, :test do
  gem 'rspec-rails', '~> 3.4'
  gem 'faker'
  gem 'terminal-notifier-guard', '~> 1.6.1'
end

group :test do
  gem 'factory_girl_rails'
  gem 'database_cleaner'
  gem 'shoulda-matchers'
end