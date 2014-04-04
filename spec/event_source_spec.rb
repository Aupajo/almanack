require 'spec_helper'

module Almanac
  describe EventSource do
    it "accepts an array of events" do
      EventSource.new [
          { title: "Soul Cake Tuesday" }
      ]
    end

    describe "#events_between" do
      it "returns events between two dates" do
        source = EventSource.new [
          { title: "Soul Cake Tuesday" },
          { title: "Hogswatch" }
        ]

        from = DateTime.now
        to = from + 30

        expect(source.events_between(from..to)).to eq([
          { title: "Soul Cake Tuesday" },
          { title: "Hogswatch" }
        ])
      end
    end
  end
end