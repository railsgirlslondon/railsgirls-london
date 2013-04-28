require 'net/http'

class Kippt
  class Clip < Struct.new(:title, :link, :kippt_url) 
  end

  class << self
    def get_clips
      return [] unless config.configured?

      kippt = new
      data =  JSON.parse(kippt.get("clips").body)["objects"]
      kippt.parse_clips(data)
    end

    def configure
      yield config
    end

    def config
      @_config ||= KipptConfig.new
    end
  end

  def initialize(host=Kippt.config.host)
    @host = host
  end

  def parse_clips clips
    clips.map do |clip|
      Clip.new(clip["title"], clip["url"], clip["app_url"])
    end
  end

  def get(path)
    http.get(full_path(path), Kippt.config.headers)
  end

  private
  def full_path(path)
    [@host, path].compact.join('/')
  end

  def uri
    uri = URI.parse(@host)
  end

  def http
    @http ||= begin
      http = Net::HTTP.new(uri.host, uri.port)
      if uri.port == 443
        http.use_ssl = true
        http.verify_mode = OpenSSL::SSL::VERIFY_NONE
      end
      http
    end
  end
end
