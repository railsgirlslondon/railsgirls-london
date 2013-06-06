require 'net/http'

module Events
  class GeocodeAddress

    GEOCODE_URI = URI('https://maps.googleapis.com/maps/api/geocode/json')

    def self.to_coordinates(address)
      response = Net::HTTP.get_response(geocode_url(address: address))
    
      if results = JSON.parse(response.body).fetch('results')
        results.first['geometry']['location']
      end
    end

    private 
    def self.geocode_url(address: '')
      uri = GEOCODE_URI
      uri.query = URI.encode_www_form(
        address: address, 
        sensor: false 
      )
      uri
    end
  end
end
