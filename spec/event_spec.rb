require 'spec_helper'

module Almanack
  describe Event do

    it "has a title" do
      event = Event.new(title: "Music with rocks in")
      expect(event.title).to eq("Music with rocks in")
    end

    it "has a start date" do
      event = Event.new(start_date: DateTime.new(2014, 01, 01))
      expect(event.start_date).to eq(DateTime.new(2014, 01, 01))
    end

    it "has a end date" do
      event = Event.new(end_date: DateTime.new(2014, 01, 02))
      expect(event.end_date).to eq(DateTime.new(2014, 01, 02))
    end

    it "has a location" do
      event = Event.new(location: "Street of Cunning Artificers")
      expect(event.location).to eq("Street of Cunning Artificers")
    end

    it "has a description" do
      event = Event.new(description: "Be there or be a rectangular thynge.")
      expect(event.description).to eq("Be there or be a rectangular thynge.")
    end

  end
end