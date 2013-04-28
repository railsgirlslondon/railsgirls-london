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