require 'spec_helper'

module Almanack::EventSource
  describe MeetupGroup do
    describe "#events_between" do
      it "returns a list of events" do
        feed = MeetupGroup.new(group_urlname: 'The-Foundation-Christchurch', key: 'secrettoken')
        events = nil

        Timecop.freeze(2014, 5, 24) do
          VCR.use_cassette('meetup') do
            from = Time.now
            to = from + 30 * 24 * 60 * 60
            events = feed.events_between(from..to)
          end
        end

        start_dates = events.map(&:start_date)

        expect(events.length).to eq(5)
        expect(events).to all_have_properties(:title, :start_date, :end_date, :description, :location)
      end

      it "handles a missing location" do
        feed = MeetupGroup.new(group_urlname: 'adventurewellington', key: 'secrettoken')

        Timecop.freeze(2014, 7, 23) do
          VCR.use_cassette('meetup-without-location') do
            from = Time.now
            to = from + 30 * 24 * 60 * 60
            expect { feed.events_between(from..to) }.not_to raise_error
          end
        end
      end
    end

  end
end
