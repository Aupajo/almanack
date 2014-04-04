require 'spec_helper'

module Almanac
  describe IcalFeed do
    it "accepts a URL" do
      IcalFeed.new("http://example.org/ical.ics")
    end

    describe "#events_between" do
      it "returns a list of events" do
        feed = IcalFeed.new('https://www.google.com/calendar/ical/61s2re9bfk01abmla4d17tojuo%40group.calendar.google.com/public/basic.ics')
        events = nil

        Timecop.freeze(2014, 4, 3) do
          VCR.use_cassette('google_calendar') do
            from = DateTime.now
            to = from + 30
            events = feed.events_between(from..to)
          end
        end

        unique_titles = events.map(&:title).uniq.sort

        expect(events.length).to eq(15)
        expect(unique_titles).to eq([
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