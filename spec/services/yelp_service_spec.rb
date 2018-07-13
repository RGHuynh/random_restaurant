require 'rails_helper'

require_relative '../../app/services/yelp_service.rb'

describe YelpService do
  let(:yelp) {YelpService.new(YELP_DEFAULT_PARAMS)}

  BUSINESS_ID = "WavvLdfdP6g8aZTtbBQHTw"

  YELP_DEFAULT_PARAMS = {
    business_id: "yelp-san-francisco",
    term: "dinner",
    location: "New York City",
    sort_by: "best_match",
    limit: 50,
    price: nil,
  }

  it 'created a new yelp object' do
    expect(yelp).to be_a YelpService
  end

  it 'get yelp response from server' do
    expect(yelp.send(:get_yelp_response, YELP_DEFAULT_PARAMS).code).to be 200
  end

  it 'get yelp search review response' do
    expect(yelp.send(:get_yelp_search_review, BUSINESS_ID).code).to be 200
  end

  it 'generate a random number' do 
    expect(yelp.send(:generate_random_number, [1,2,3,4])).to be_a Integer
  end

  it 'returns a random restaurant' do
    expect(yelp.send(:get_random_restaurant, yelp.send(:get_yelp_response, YELP_DEFAULT_PARAMS).parse)).to be_a Array
  end

  it 'returns default parameter' do 
    expect(yelp.send(:yelp_default_params)).to be_a Hash
  end

  it 'returns a restaurant data' do
    expect(yelp.get_restaurant).to be_a Hash
  end

end