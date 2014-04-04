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

    describe "#events" do
      describe "with simple events" do
        it "returns the events" do
          config = Configuration.new
          config.add_events [
            { title: "Hogswatch" }
          ]

          expect(config.events).to eq([
            { title: "Hogswatch" }
          ])
        end
      end

      describe "with an iCal feed" do
        it "returns the event occurrences" do
          config = Configuration.new
          config.add_ical_feed "https://www.google.com/calendar/ical/61s2re9bfk01abmla4d17tojuo%40group.calendar.google.com/public/basic.ics"

          events = nil

          Timecop.freeze(2014, 4, 3) do
            VCR.use_cassette('google_calendar') do
              events = config.events
            end
          end

          titles = events.map { |e| e[:title] }

          expect(events.length).to eq(15)
          expect(titles.uniq.sort).to eq([
            "Christchurch Python Meetup",
            "Coffee & Jam",
            "Ruby Meetup @catalyst - Tanks! Guns!",
            "The Foundation",
            "WikiHouse/NZ weekly meet-up"
          ])
        end
      end
    end

  end
end