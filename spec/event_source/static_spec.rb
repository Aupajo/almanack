require 'spec_helper'

module Almanack::EventSource
  describe Static do
    let(:yesterday) { now - 1 }
    let(:now) { Time.now }
    let(:tomorrow) { now + 1 }

    around do |test|
      Timecop.freeze(now, &test)
    end

    describe "#events_between" do
      it "returns events between two dates" do
        source = Static.new [
          { title: 'Yesterday', start_time: yesterday },
          { title: 'Today', start_time: now },
          { title: 'Tomorrow', start_time: tomorrow }
        ]

        expect(source.events_between(yesterday..tomorrow).map(&:title)).to eq(%w( Yesterday Today Tomorrow ))
        expect(source.events_between(now..tomorrow).map(&:title)).to eq(%w( Today Tomorrow ))
        expect(source.events_between(yesterday..now).map(&:title)).to eq(%w( Yesterday Today ))
      end
    end

    describe "#serialized_between" do
      it "returns a hash containing attributes" do
        source = Static.new []
        date_range = yesterday..tomorrow

        events = [double(serialized: :serialized_event)]
        expect(source).to receive(:events_between).with(date_range) { events }

        expect(source.serialized_between(date_range)).to eq({
          events: [:serialized_event]
        })
      end
    end
  end
end
