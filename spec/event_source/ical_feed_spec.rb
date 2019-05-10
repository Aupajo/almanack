
module Almanack::EventSource
  RSpec.describe IcalFeed do
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

        start_times = events.map(&:start_time)

        expect(events.length).to eq(15)
        expect(events).to all_have_properties(:title, :start_time, :end_time, :description, :location)
      end
    end

    describe "#serialized_between" do
      it "returns a hash containing attributes" do
        source = IcalFeed.new 'url'

        events = [double(serialized: :serialized_event)]
        expect(source).to receive(:events_between).with(:date_range) { events }

        expect(source.serialized_between(:date_range)).to eq({
          events: [:serialized_event]
        })
      end
    end

  end
end
