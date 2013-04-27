class Kippt::Config
  attr_accessor :host
  attr_writer :token, :username

  def headers
    {
      "X-Kippt-Username" => @username,
      "X-Kippt-API-Token" => @token
    }
  end
end

Kippt.configure do |config|
  if Rails.env.development? || Rails.env.test?
    yaml = YAML.load_file(Rails.root.join("config/kippt.yml"))
    config.username = yaml['username']
    config.token = yaml['token']
  else
    config.username = ENV['KIPPT_USERNAME']
    config.token = ENV['KIPPT_TOKEN']
  end

  config.host = "https://kippt.com/api"
end