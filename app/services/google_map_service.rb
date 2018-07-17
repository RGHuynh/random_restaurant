
require 'pry'

class GoogleMapService

  def get_google_map_result(data)
    p get_google_map_response(data).parse
  end
  
  private

  GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']
  GOOGLE_API_HOST = "https://maps.googleapis.com"
  GOOGLE_MAP_PATH = "/maps/api/geocode/json?address="

  def get_google_map_response(data)
    address = data[:address].gsub(/\s/, '+')
    city = data[:city].gsub(/\s/, '+')
    state = data[:state]
    response = HTTP.get("#{GOOGLE_API_HOST}#{GOOGLE_MAP_PATH}#{address},+#{city},+#{state}&key=#{GOOGLE_API_KEY}")
  end

end