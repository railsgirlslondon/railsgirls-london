source 'https://rubygems.org'

ruby '2.0.0'

gem 'rails', '~> 4.0.0'
gem 'unicorn'

gem 'haml-rails'
gem 'simple_form', '~> 3.0.0.rc'
gem 'devise', '~> 3.0.0.rc'
gem 'protected_attributes' # temporary
gem 'ruby-trello', require: false
gem 'pg'

group :production do
  gem 'rails_12factor'
end

group :test, :development do
  gem 'pry-debugger'
  gem 'sqlite3'
  gem 'rspec-rails'
end

group :test do
  gem 'faker'
  gem 'shoulda-matchers'
  gem 'rspec-given'
  gem 'capybara'
  gem 'vcr'
  gem 'launchy'
  gem 'database_cleaner'
  gem 'fabrication'
  gem 'coveralls', require: false
  gem 'webmock', "< 1.10"
end

group :assets do
  gem 'coffee-rails', '~> 4.0.0.rc1'
  gem 'uglifier', '>= 1.3.0'
end

gem 'jquery-rails'
gem 'sass-rails',   '~> 4.0.0.rc1'
gem 'bootstrap-sass'
