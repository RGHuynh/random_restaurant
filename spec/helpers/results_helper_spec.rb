require 'rails_helper'

# Specs in this file have access to a helper object that includes
# the ResultsHelper. For example:
#
# describe ResultsHelper do
#   describe "string concat" do
#     it "concats two strings with spaces" do
#       expect(helper.concat_strings("this","that")).to eq("this that")
#     end
#   end
# end
describe ResultsHelper do 

  describe "Yelp" do
    let(:yelp_api) {ResultsHelper::Yelp}

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
    let(:googleMap) {ResultsHelper::GoogleMap}

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

end

