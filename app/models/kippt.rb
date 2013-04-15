require 'net/http'
require 'json'

class Kippt

  class Clip < Struct.new(:title, :link, :kippt_url) 
    def self.all
      Kippt.get_clips
    end
  end

  TOKEN = "b01e96fa40ffde86d642319fe3e0df2681358bfc"
  USERNAME = "railsgirlslondon"
  KIPPT_HOST = "https://kippt.com/api"

  HEADERS = {
    "X-Kippt-Username" => USERNAME,
    "X-Kippt-API-Token" => TOKEN
  }

  def initialize(host=KIPPT_HOST)
    @host = host
  end

  def self.get_clips
    kippt = new
    data =  JSON.parse(kippt.get("clips").body)["objects"]
    kippt.parse_clips(data)
  end

  def parse_clips clips
    clips.map do |clip|
      Clip.new(clip["title"], clip["url"], clip["app_url"])
    end
  end

  def get(path)
    request = Net::HTTP::Get.new(path)
    http.get(full_path(path), HEADERS)
  end

  private
  def full_path(path)
    [KIPPT_HOST, path].compact.join('/')
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
