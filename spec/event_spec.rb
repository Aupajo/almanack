require 'spec_helper'

module Almanac
  describe Event do

    it "has a title" do
      event = Event.new(title: "Hogswatch")
      expect(event.title).to eq("Hogswatch")
    end

  end
end