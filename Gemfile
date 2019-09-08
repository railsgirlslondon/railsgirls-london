source 'http://rubygems.org'

ruby '2.6.3'

gem 'rails', '~> 5.0.0'
gem 'unicorn'
gem 'pg'
gem 'sass-rails'
gem 'jquery-rails'
gem 'haml-rails'
gem 'devise'

gem 'bootstrap-sass'
gem 'bourbon'
gem 'neat'
gem 'simple_form'
gem 'evil_icons' # SVG icon set
gem 'autoprefixer-rails'

gem 'icalendar'
gem 'ruby-trello', require: false
gem 'newrelic_rpm'

gem 'premailer-rails'
gem 'nokogiri'
gem 'letter_opener', '~> 1.4'

group :production do
  gem 'rails_12factor'
end

group :development do
  gem "better_errors"
  gem 'binding_of_caller'
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
  gem 'rails-controller-testing'
  gem 'rspec-collection_matchers'
  gem 'shoulda-matchers'
  gem 'shoulda-callback-matchers', '>=0.3.0'
  gem 'rspec-given'
  gem 'capybara'
  gem 'vcr'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'coveralls', require: false
  gem 'webmock', '< 1.10'
end

group :assets do
  gem 'coffee-rails'
  gem 'uglifier'
end
