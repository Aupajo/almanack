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

        now = Time.now
        lookahead = 42
        future = now + lookahead * 24 * 60 * 60

        Timecop.freeze(now) do
          expect(calendar).to receive(:days_lookahead) { lookahead }
          expect(calendar).to receive(:events_between) do |date_range|
            expect(date_range.min).to eq_time(now)
            expect(date_range.max).to eq_time(future)
            :results
          end

          expect(calendar.events).to eq(:results)
        end
      end
    end

    describe "#events_between" do
      it "collects the event sources' events between two dates" do
        today = Time.now
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

    describe "#days_lookahead" do
      it "delegates to the configuration's days_lookahead" do
        config = double(days_lookahead: :delegated)
        expect(Calendar.new(config).days_lookahead).to eq(:delegated)
      end
    end

    describe "#feed_lookahead" do
      it "delegates to the configuration's feed_lookahead" do
        config = double(feed_lookahead: :delegated)
        expect(Calendar.new(config).feed_lookahead).to eq(:delegated)
      end
    end

  end
end
