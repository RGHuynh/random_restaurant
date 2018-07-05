class ResultsController < ApplicationController
  require 'http'
  require 'json'
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

   def GoogleParams
      maps = {latitude: 70.3229999, longitude: -99.0200202}
      @map2 = maps.to_json
      return maps.to_json

   end
  end



  private

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
    if params[key].nil? || params[key] == ""

      DEFAULT_PARAMS[key]
    else
      value
    end
  end
end

