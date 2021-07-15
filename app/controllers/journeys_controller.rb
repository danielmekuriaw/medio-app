class JourneysController < ApplicationController

    def Formatted_Address(keyword)
        api_key = 'AIzaSyAmCf0SWHM3vMqJi6oCkLkPaRq3GJ57tis'
        gmaps = GoogleMapsService::Client.new(key: api_key)
        
        url = "https://maps.googleapis.com/maps/api/place/findplacefromtext/json?input=#{keyword}&inputtype=textquery&fields=photos,formatted_address,name,rating,opening_hours,geometry&key=#{api_key}"
        uri = URI(url)
        response = Net::HTTP.get(uri)
        JSON.parse(response)
    end
     

end