require 'http'
require 'pry'

module ResultService
 
  class GoogleMap
    
    def self.get_search(params)
      get_google_search(params).parse
    end

    private

    GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']
    GOOGLE_API_HOST = "https://maps.googleapis.com"
    GOOGLE_MAP_PATH = "/maps/api/geocode/json?address="

    private_class_method def self.get_google_search(params)
      address = params[:address].gsub(/\s/, '+')
      city = params[:city].gsub(/\s/, '+')
      state = params[:state]
      response = HTTP.get("#{GOOGLE_API_HOST}#{GOOGLE_MAP_PATH}#{address},+#{city},+#{state}&key=#{GOOGLE_API_KEY}")
      response
    end
  end
end