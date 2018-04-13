class ResultsController < ApplicationController
  require 'http'
  protect_from_forgery

  def index

    # params = {
    #   location: params[:location],
    #   sort_by: params[:sort_by],
    #   limit: 50,
    #   longitude: params[:longitude],
    #   latitude: params[:latitude],
    #   price: params[:price],
    #   radius: params[:radius],
    #   attributes: params[:attributes],
    #   categories: params[:categories]
    # }

    # binding.pry

    user_preference = {
      location: "san francisco",
      sort_by: params[:sort_by],
      limit: 50,
      price: params[:price]
    }

    filtered_params = {}

    user_preference.each do |k, v|
      filtered_params[k] = default_check(user_preference, k, v)
    end

    json_data = search(filtered_params)



    @result = random_restaurant(json_data["businesses"])

    @googleResult = google_Search
    puts @googleResult

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
    price: ['1', '2', '3', '4']
  }

  def google_Search()

    #str.gsub!(/\s/, ‘+’)
    response = HTTP.get("https://maps.googleapis.com/maps/api/geocode/json?address=5-48+49th+Ave,+Long+Island+City,+NY&key=AIzaSyAk4AFScfe71HoUesrTGA0MHdSg4l_M-wI")
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
    if parms[key].nil?
      DEFAULT_PARAMS[key]
    else
      value
    end
  end
end

