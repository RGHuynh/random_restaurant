require 'http'

class YelpService

  def initialize(params)
    @user_preference = {
      latitude: params[:latitude],
      longitude: params[:longitude],
      location: params[:location],
      sort_by: params[:sort_by],
      limit: 50,
      price: params[:price],
      latitude: params[:latitude],
      longitude: params[:longitude]
    }
  end

  def get_restaurant
    filter_params = {}
    @user_preference
    @user_preference.each do |k, v| 
      filter_params[k] = check_for_nil(@user_preference, k)
    end
    yelp_response = get_yelp_response(filter_params).parse['businesses']
    random_restaurant = get_random_restaurant(yelp_response)
  end

  private

  YELP_API_KEY = ENV['API_KEY']
  YELP_API_HOST = "https://api.yelp.com"
  YELP_SEARCH_PATH = "/v3/businesses/search"
  YELP_BUSINESS_PATH = "/v3/businesses/" 

  def yelp_default_params
  end

  def get_yelp_response(params)
    url = "#{YELP_API_HOST}#{YELP_SEARCH_PATH}"
    response = HTTP.auth("Bearer #{YELP_API_KEY}").get(url, params: params)
    response
  end

  def get_yelp_search_review(id)
    url = "#{YELP_API_HOST}#{YELP_BUSINESS_PATH}#{id}/reviews"
    response = HTTP.auth("Bearer #{YELP_API_KEY}").get(url)
    response
  end

  def generate_random_number(item)
    max_count = item.count
    rand(max_count)
  end  

  def get_random_restaurant(data)
    array = []
    data.each {|business| array << business }
    array.count
    selected_number = generate_random_number(array)
    array[selected_number] 
  end

  def yelp_default_params
    params = {
      business_id: "yelp-san-francisco",
      term: "dinner",
      location: "New York City",
      sort_by: "best_match",
      limit: 50,
      price: ['1', '2', '3', '4'],
    }
  end

  def check_for_nil(data, key)
    if data[key] != ""
      return data[key]
    end
    
    return yelp_default_params[key]
  end

end