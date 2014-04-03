require 'spec_helper'


module Almanac
  describe Configuration do
    
    describe "#add_ical_feed" do
      it "accepts a URL" do
        config = Configuration.new
        config.add_ical_feed "http://example.org/feed.ics"
      end
    end
    
    describe "#add_events" do
      it "accepts an array" do
        config = Configuration.new
        config.add_events [
          { title: "Soul Cake Tuesday" }
        ]
      end
    end

  end
end