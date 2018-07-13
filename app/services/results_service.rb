require 'http'
require 'pry'

module ResultService
  class Yelp 

    def self.generate_number(item)
      generate_random_number(item)
    end

    def self.get_search_review(id)
      get_yelp_search_review(id).parse
    end

    def self.get_restaurant(data)
      filtered_params = {}

      binding.pry

      data.each do |k, v|
        filtered_params[k] = default_check(data, k, v)
      end

      yelp_reponse = get_yelp_response(filtered_params).parse
      get_random_restaurant(yelp_reponse)
    end

    private 

    YELP_API_KEY = ENV['API_KEY']
    YELP_API_HOST = "https://api.yelp.com"
    YELP_SEARCH_PATH = "/v3/businesses/search"
    YELP_BUSINESS_PATH = "/v3/businesses/" 
    
    
    def self.yelp_default_params 
      params = {
        business_id: "yelp-san-francisco",
        term: "dinner",
        location: "New York City",
        sort_by: "best_match",
        limit: 50,
        price: ['1', '2', '3', '4'],
      }
    end


    # private_class_method def self.get_yelp_response(params)
    #   url = "#{YELP_API_HOST}#{YELP_SEARCH_PATH}"
    #   response = HTTP.auth("Bearer #{YELP_API_KEY}").get(url, params: params)
    #   response
    # end

    # private_class_method def self.get_yelp_search_review(id)
    #   url = "#{YELP_API_HOST}#{YELP_BUSINESS_PATH}#{id}/reviews"
    #   response = HTTP.auth("Bearer #{YELP_API_KEY}").get(url)
    #   response
    # end

    # private_class_method def self.generate_random_number(item)
    #   max_count = item.count
    #   rand(max_count)
    # end

    private_class_method def self.get_random_restaurant(data)
      array = []
      data.each {|business| array << business }
      selected_number = generate_random_number(array)
      array[selected_number] 
    end

    def self.default_check(data, k, v)
      if v != nil
        p v
        return v
      end

      p yelp_default_params[k]
      return yelp_default_params[k]
    end

  end

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