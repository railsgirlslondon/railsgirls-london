# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV["RAILS_ENV"] ||= 'test'
require File.expand_path("../../config/environment", __FILE__)
require 'rspec/rails'
require 'rspec/autorun'
require 'rspec/given'
require 'vcr'
require 'webmock/rspec'
require 'capybara/rails'

if ENV['CI']
  require 'coveralls'
  Coveralls.wear!
end

RSpec::Given.use_natural_assertions

Dir[Rails.root.join("spec/support/**/*.rb")].each { |f| require f }

VCR.configure do |c|
  c.cassette_library_dir = 'spec/support/vcr_cassettes'
  c.hook_into :webmock
end

module FeatureHelpers
  def admin_logged_in!
    User.create!(email: "admin@railsgirls.co.uk", password: "admin12345")

    visit new_user_session_path

    fill_in "Email", with: "admin@railsgirls.co.uk"
    fill_in "Password", with: "admin12345"
    click_on "Sign in"
  end

end

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_base_class_for_anonymous_controllers = false
  config.order = "random"
  config.include Devise::TestHelpers, type: :controller
  config.include ControllerHelpers, type: :controller
  config.include FeatureHelpers, type: :feature
  
  config.before(:all) do
    DeferredGarbageCollection.start
  end

  config.after(:all) do
    DeferredGarbageCollection.reconsider
  end
end

