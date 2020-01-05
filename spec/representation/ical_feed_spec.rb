module Almanack::Representation
  RSpec.describe "IcalFeed" do
    before { Almanack.reset! }

    it "handles events with dates" do
      fixture = read_fixture('cal-with-dates.ical')

      Almanack.config.add_ical(fixture)

      Timecop.freeze(1962, 2, 10) do
        feed = IcalFeed.from(Almanack.calendar)

        parsed = Icalendar::Calendar.parse(feed.to_s)

        first_event = parsed.first.events.first

        expect(first_event.summary).to eq 'MA-6 First US Manned Spaceflight'
        expect(first_event.dtstart).to eq Date.parse("1962-2-20")
        expect(first_event.dtend).to eq Date.parse("1962-2-20")
      end
    end
  end
end
