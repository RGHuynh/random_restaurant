require 'rails_helper'

require_relative '../../app/services/results_service.rb'

describe "Yelp" do
  let(:yelp_api) {ResultService::Yelp}

  BUSINESS_ID = "WavvLdfdP6g8aZTtbBQHTw"

  YELP_DEFAULT_PARAMS = {
    business_id: "yelp-san-francisco",
    term: "dinner",
    location: "New York City",
    sort_by: "best_match",
    limit: 50,
    price: ['1', '2', '3', '4'],
  }

  it "get business response" do
    expect(yelp_api.send(:get_yelp_response, YELP_DEFAULT_PARAMS).code).to be 200
  end

  it "parse businese response" do 
    expect(yelp_api.get_response(YELP_DEFAULT_PARAMS)).to be_a(Hash)
  end

  it "get business review response" do
    expect(yelp_api.send(:get_yelp_search_review, BUSINESS_ID).code).to be 200
  end

  it "parse business review response" do 
    expect(yelp_api.get_search_review(BUSINESS_ID)).to be_a(Hash)
  end
end

describe "GoogleMap" do
  let(:googleMap) {ResultService::GoogleMap}

  GOOGLE_DEFAULT_PARAMS = {
    address: "800 N Point St",
    city: "San Francisco",
    state: "CA"
  }

  it "get google map response" do 
    expect(googleMap.send(:get_google_search, GOOGLE_DEFAULT_PARAMS).code).to be 200
  end

  it "parse google map response" do 
    expect(googleMap.get_search(GOOGLE_DEFAULT_PARAMS)).to be_a(Hash)
  end
end