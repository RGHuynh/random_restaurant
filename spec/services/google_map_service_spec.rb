require 'http'

require_relative '../../app/services/google_map_service.rb'

describe GoogleMapService do
  let(:googleMap) {GoogleMapService.new}

  GOOGLE_DEFAULT_PARAMS = {
    address: "800 N Point St",
    city: "San Francisco",
    state: "CA"
  }
  
  it "get google map response" do 
    expect(googleMap.send(:get_google_map_response, GOOGLE_DEFAULT_PARAMS).code).to be 200
  end

  it "get google map result" do
    expect(googleMap.get_google_map_result(GOOGLE_DEFAULT_PARAMS)).to be_a Hash
  end

end