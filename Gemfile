source 'https://rubygems.org'

ruby '1.9.3'

gem 'rails', '3.2.13'

gem 'haml-rails'
gem 'simple_form'
gem 'redcarpet'
gem 'devise'

group :production do
  gem 'pg'
end

group :test, :development do
  gem 'sqlite3'
end

group :test do
  gem 'rspec-rails'
  gem 'shoulda-matchers'
  gem 'vcr'
  gem 'fakeweb'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner'
  gem 'coveralls', require: false
end

group :assets do
  gem 'coffee-rails', '~> 3.2.1'
  gem 'uglifier', '>= 1.0.3'
end

gem 'jquery-rails'
gem 'sass-rails',   '~> 3.2.3'
gem 'bootstrap-sass'
