class HomepageController < ApplicationController
  def index
    @api = ENV['GOOGLE_API_KEY']
  end
end
