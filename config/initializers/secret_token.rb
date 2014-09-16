# Be sure to restart your server when you modify this file.

# Your secret key for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!
# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.

if Rails.env.development? or Rails.env.test?
  secret_token = ('x' * 30)
  secret_key_base = ('x' * 30)
else
  secret_token = ENV['RG_SECRET_TOKEN']
  secret_key_base = ENV['RG_SECRET_KEY_BASE']
end

RailsgirlsLondon::Application.config.secret_token = secret =  secret_token
RailsgirlsLondon::Application.config.secret_key_base = secret =  secret_key_base
