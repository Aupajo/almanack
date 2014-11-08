require 'spec_helper'

module Almanack::Representation
  describe JSONFeed do

    describe ".from" do
      it "returns empty JSON by default" do
        raw_json = JSONFeed.from(Almanack.calendar)
        parsed_json = JSON.parse(raw_json)
        expect(parsed_json).to eq({})
      end
    end
    
  end
end
