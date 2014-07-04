require 'spec_helper'

module Almanack::EventSource
  describe Static do
    describe "#events_between" do
      it "returns events between two dates" do
        basic_events = Static.new [
          { title: "Soul Cake Tuesday" },
          { title: "Hogswatch" }
        ]

        from = DateTime.now
        to = from + 30

        events = basic_events.events_between(from..to)

        expect(events.size).to eq(2)
        expect(events.first.title).to eq("Soul Cake Tuesday")
        expect(events.last.title).to eq("Hogswatch")
      end
    end
  end
end
