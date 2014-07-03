require 'spec_helper'

module Almanack
  describe Calendar do

    describe "#title" do
      it "delegates to the config's title" do
        config = Configuration.new
        config.title = "Discworld Holidays"
        calendar = Calendar.new(config)
        expect(calendar.title).to eq("Discworld Holidays")
      end
    end

    describe "#events" do
      describe "with simple events" do
        it "returns the events" do
          config = Configuration.new
          config.add_events [
            { title: "Hogswatch" }
          ]

          calendar = Calendar.new(config)

          expect(calendar.events.size).to eq(1)
          expect(calendar.events.first.title).to eq('Hogswatch')
        end
      end

      describe "with an iCal feed" do
        it "returns the event occurrences" do
          config = Configuration.new
          config.add_ical_feed "https://www.google.com/calendar/ical/61s2re9bfk01abmla4d17tojuo%40group.calendar.google.com/public/basic.ics"

          calendar = Calendar.new(config)

          events = nil

          Timecop.freeze(2014, 4, 3) do
            VCR.use_cassette('google_calendar') do
              events = calendar.events
            end
          end

          expect(events.size).to eq(15)
          expect(events).to all_have_properties(:title, :start_date)
          expect(events).to be_in_order
        end
      end
    end

    it "has a 30 day lookahead" do
      expect(Calendar.new(double).days_lookahead).to eq(30)
    end

  end
end
