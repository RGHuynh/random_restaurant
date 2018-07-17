require 'json'
require 'pry'

class ResultsController < ApplicationController
  def index
    yelp = YelpService.new(params)
    @restaurant = yelp.get_restaurant
    @restaurant_comments = yelp.get_comments(@restaurant['id'])

    # @result = random_restaurant(json_data["businesses"])
    # paramsResult = {
    #   address: @result['location']['address1'],
    #   city: @result['location']['city'],
    #   state: @result['location']['state']
    # }
   
    # @googleResult = google_Search(paramsResult)
    
    # @comment = search_review(@result["id"])

    render :layout => false
  end
end

