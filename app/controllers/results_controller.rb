require 'json'
require 'pry'

class ResultsController < ApplicationController
  def index
    yelp = YelpService.new(params)

    @restaurant = yelp.get_restaurant
    @restaurant_comments = yelp.get_comments(@restaurant['id'])

    # paramsResult = {
    #   address: @restaurant['location']['address1'],
    #   city: @restaurant['location']['city'],
    #   state: @restaurant['location']['state']
    # }
   
    # @googleResult = google_Search(paramsResult)
    
    # @comment = search_review(@result["id"])

    render :layout => false
  end
end

