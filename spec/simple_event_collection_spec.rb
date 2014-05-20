require 'spec_helper'

module Almanac
  describe SimpleEventCollection do
    describe "#events_between" do
      it "returns events between two dates" do
        basic_events = SimpleEventCollection.new [
          { title: "Soul Cake Tuesday" },
          { title: "Hogswatch" }
        ]

        from = DateTime.now
        to = from + 30

        events = basic_events.events_between(from..to)

        expect(events).to have(2).events
        expect(events.first.title).to eq("Soul Cake Tuesday")
        expect(events.last.title).to eq("Hogswatch")
      end
    end
  end
end