class ResultsController < ApplicationController
  require 'http'
  protect_from_forgery

  def index

    user_preference = {
      latitude: params[:latitude],
      longitude: params[:longitude],
      location: params[:location],
      sort_by: params[:sort_by],
      limit: 50,
      price: params[:price],
      latitude: params[:latitude],
      longitude: params[:longitude]
    }

    filtered_params = {}

    user_preference.each do |k, v|
      filtered_params[k] = default_check(user_preference, k, v)
    end

    json_data = search(filtered_params)

    @result = random_restaurant(json_data["businesses"])
    paramsResult = {
      address: @result['location']['address1'],
      city: @result['location']['city'],
      state: @result['location']['state']
    }
    
    @googleResult = google_Search(paramsResult)
    
    @comment = search_review(@result["id"])

    render :layout => false

  end

  private

  API_KEY = ENV['API_KEY']
  API_HOST = "https://api.yelp.com"
  SEARCH_PATH = "/v3/businesses/search"
  BUSINESS_PATH = "/v3/businesses/" 
  GOOGLE_API_KEY = ENV['GOOGLE_API_KEY']
  DEFAULT_PARAMS = {
    business_id: "yelp-san-francisco",
    term: "dinner",
    location: "New York City",
    sort_by: "best_match",
    limit: 50,
    price: ['1', '2', '3', '4'],
    latitude: 40.7666695,
    longitude: -73.82376169999
  }

  def google_Search(params)

    #str.gsub!(/\s/, ‘+’)
    address = params[:address].gsub(/\s/, '+')
    city = params[:city].gsub(/\s/, '+')
    state = params[:state]
    response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=#{address},+#{city},+#{state}&key=#{GOOGLE_API_KEY}")
    response.parse
  end

  def search(params)
    url = "#{API_HOST}#{SEARCH_PATH}"
    response = HTTP.auth("Bearer #{API_KEY}").get(url, params: params)
    response.parse
  end

  def search_review(id)
    url = "#{API_HOST}#{BUSINESS_PATH}#{id}/reviews"
    response = HTTP.auth("Bearer #{API_KEY}").get(url)
    response.parse
  end

  def random_number(item)
    max_count = item.count
    rand(max_count)
  end

  def random_restaurant(data)
    array = []
    data.each {|business| array << business }
    selected_number = random_number(array)
    array[selected_number] 
  end

  def default_check(parms, key, value)
    if parms[key].nil? || parms[key] == ""

      DEFAULT_PARAMS[key]
    else
      value
    end
  end
end

