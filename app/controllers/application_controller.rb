class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  gmaps = GoogleMapsService::Client.new(key: 'AIzaSyAmCf0SWHM3vMqJi6oCkLkPaRq3GJ57tis')
  
end
