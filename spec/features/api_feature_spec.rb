require 'spec_helper'

describe "API", :feature do
  before { Almanack.reset! }

  describe "/feed.json" do
    it "has a JSON content-type" do
      get '/feed.json'
      expect(last_response['Content-Type']).to eq 'application/json'
    end

    it "reutrns the JSON feed" do
      allow(Almanack.calendar).to receive(:json_feed) { "feed" }
      get '/feed.json'
      expect(last_response.body).to eq("feed")
    end
  end
end
