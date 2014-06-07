require 'spec_helper'

module Almanac
  describe Configuration do

    describe "#add_events" do
      it "adds a simple event collection event source" do
        config = Configuration.new
        expect(config.event_sources.size).to eq(0)

        config.add_events [
          { title: "Hogswatch" }
        ]

        expect(config.event_sources.size).to eq(1)
        expect(config.event_sources.first).to be_an_instance_of(SimpleEventCollection)
      end
    end

    describe "#ical_feed" do
      it "adds an iCal feed event source" do
        config = Configuration.new
        expect(config.event_sources.size).to eq(0)

        config.add_ical_feed "https://www.google.com/calendar/ical/61s2re9bfk01abmla4d17tojuo%40group.calendar.google.com/public/basic.ics"
        
        expect(config.event_sources.size).to eq(1)
        expect(config.event_sources.first).to be_an_instance_of(IcalFeed)
      end
    end

    describe "#meetup_group" do
      it "adds a Meetup group event source" do
        config = Configuration.new
        expect(config.event_sources.size).to eq(0)

        config.add_meetup_group(group_urlname: "CHC-JS", key: "secrettoken")
        
        expect(config.event_sources.size).to eq(1)
        expect(config.event_sources.first).to be_an_instance_of(MeetupGroup)
      end
    end

  end
end