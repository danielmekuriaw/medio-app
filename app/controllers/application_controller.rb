class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception

  gmaps = GoogleMapsService::Client.new(key: 'AIzaSyAmCf0SWHM3vMqJi6oCkLkPaRq3GJ57tis')

  include ApplicationHelper

  private

  def redirect_if_not_logged_in
    redirect_to login_path if !logged_in?
  end
  
end
