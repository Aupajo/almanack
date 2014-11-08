require 'spec_helper'

describe "API", :feature do
  before { Almanack.reset! }

  describe "/feed.json" do
    it "has a JSON content-type" do
      get '/feed.json'
      expect(last_response['Content-Type']).to eq 'application/json'
    end

    it "is empty by default" do
      get '/feed.json'
      parsed_json = JSON.parse(last_response.body)
      expect(parsed_json).to eq({})
    end
  end
end
