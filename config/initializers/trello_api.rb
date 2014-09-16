require 'trello_api'
TrelloApi.configure do |config|
  config.consumer_key = ENV['TRELLO_CONSUMER_KEY']
  config.consumer_secret = ENV['TRELLO_CONSUMER_SECRET']
  config.oauth_token = ENV['TRELLO_OATH_TOKEN']
end
