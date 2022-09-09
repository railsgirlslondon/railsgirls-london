source 'http://rubygems.org'

ruby '2.7.6'

gem 'rails', '~> 6.1.0'
gem 'unicorn'
gem 'pg'
gem 'sassc-rails'
gem 'jquery-rails'
gem 'haml-rails'
gem 'devise'

gem 'aws-sdk-s3'
gem 'rollbar'

gem 'bootstrap-sass'
gem 'bourbon', '7.2.0'
# gem 'neat'
gem 'simple_form'
gem 'evil_icons' # SVG icon set
gem 'autoprefixer-rails'

gem 'icalendar'

gem 'premailer-rails'
gem 'nokogiri'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem "better_errors"
  gem 'binding_of_caller'
  gem 'letter_opener', '~> 1.4'
end

group :test, :development do
  gem 'dotenv-rails'
  gem 'guard'
  gem 'guard-rspec', require: false
  gem 'rspec-rails'
  gem 'byebug'
  gem 'pry-rails'
  gem 'faker'
  gem 'factory_bot_rails'
end

group :test do
  # gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  # gem 'shoulda-matchers'
  # gem 'shoulda-callback-matchers', '>=0.3.0'
  # gem 'rspec-given'
  # gem 'capybara'
  gem 'vcr'
  gem 'launchy'
  gem 'database_cleaner'
  # gem 'coveralls', require: false
  gem 'webmock', '< 1.10'
end

group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
end
