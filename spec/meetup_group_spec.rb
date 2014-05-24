require 'spec_helper'

module Almanac
  describe MeetupGroup do
    describe "#events_between" do
      it "returns a list of events" do
        feed = MeetupGroup.new(group_urlname: 'The-Foundation-Christchurch', key: 'secrettoken')
        events = nil

        Timecop.freeze(2014, 5, 24) do
          VCR.use_cassette('meetup') do
            from = DateTime.now
            to = from + 30
            events = feed.events_between(from..to)
          end
        end

        start_dates = events.map(&:start_date)

        expect(events.length).to eq(5)
        expect(events).to all_have_properties(:title, :start_date, :end_date, :description, :location)
      end
    end

  end
end