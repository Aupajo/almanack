require 'spec_helper'

module Almanac
  describe Configuration do

    describe "#add_events" do
      it "adds events to the event sources" do
        config = Configuration.new
        expect(config.event_sources).to have(0).sources

        config.add_events [
          { title: "Hogswatch" }
        ]

        expect(config.event_sources).to have(1).source
        expect(config.event_sources.first).to be_an_instance_of(SimpleEventCollection)
      end
  
      it "returns the event occurrences" do
        config = Configuration.new
        expect(config.event_sources).to have(0).sources

        config.add_ical_feed "https://www.google.com/calendar/ical/61s2re9bfk01abmla4d17tojuo%40group.calendar.google.com/public/basic.ics"
        
        expect(config.event_sources).to have(1).source
        expect(config.event_sources.first).to be_an_instance_of(IcalFeed)
      end
    end

  end
end