require 'spec_helper'

module Almanack::EventSource
  describe IcalFeed do
    describe "#events_between" do
      it "returns a list of events" do
        feed = IcalFeed.new('https://www.google.com/calendar/ical/61s2re9bfk01abmla4d17tojuo%40group.calendar.google.com/public/basic.ics',
                            connection: Faraday.new)
        events = nil

        Timecop.freeze(2014, 4, 3) do
          VCR.use_cassette('google_calendar') do
            from = Time.now
            to = from + 30 * 24 * 60 * 60
            events = feed.events_between(from..to)
          end
        end

        start_dates = events.map(&:start_date)

        expect(events.length).to eq(15)
        expect(events).to all_have_properties(:title, :start_date, :end_date, :description, :location)
      end
    end

  end
end
