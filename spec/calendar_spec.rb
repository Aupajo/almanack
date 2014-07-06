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
      it "calls events_between with now and the days lookahead" do
        config = Configuration.new
        calendar = Calendar.new(config)

        now = DateTime.now
        lookahead = 42
        future = now + lookahead

        Timecop.freeze(now) do
          expect(calendar).to receive(:days_lookahead) { lookahead }
          expect(calendar).to receive(:events_between) do |date_range|
            expect(date_range.min.to_time.to_i).to eq(now.to_time.to_i)
            expect(date_range.max.to_time.to_i).to eq(future.to_time.to_i)
            :results
          end

          expect(calendar.events).to eq(:results)
        end
      end
    end

    describe "#events_between" do
      it "collects the event sources' events between two dates" do
        today = DateTime.now
        yesterday = today - 1
        tomorrow = today + 1

        config = Configuration.new
        config.add_events [
          { title: 'Today', start_date: today },
          { title: 'Yesterday', start_date: yesterday },
          { title: 'Tomorrow', start_date: tomorrow },
        ]

        calendar = Calendar.new(config)

        expect(calendar.events_between(today..tomorrow).map(&:title)).to eq(%w( Today Tomorrow ))
      end
    end

    it "has a 30 day lookahead" do
      expect(Calendar.new(double).days_lookahead).to eq(30)
    end

  end
end
