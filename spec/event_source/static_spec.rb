require 'spec_helper'

module Almanack::EventSource
  describe Static do
    describe "#events_between" do
      it "returns events between two dates" do
        now = DateTime.now
        yesterday = now - 1
        tomorrow = now + 1

        source = Static.new [
          { title: 'Yesterday', start_date: yesterday },
          { title: 'Today', start_date: now },
          { title: 'Tomorrow', start_date: tomorrow }
        ]

        expect(source.events_between(yesterday..tomorrow).map(&:title)).to eq(%w( Yesterday Today Tomorrow ))
        expect(source.events_between(now..tomorrow).map(&:title)).to eq(%w( Today Tomorrow ))
        expect(source.events_between(yesterday..now).map(&:title)).to eq(%w( Yesterday Today ))
      end
    end
  end
end
