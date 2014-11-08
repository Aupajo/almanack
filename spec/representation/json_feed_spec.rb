require 'spec_helper'

module Almanack::Representation
  describe JSONFeed do

    let(:calendar) { Almanack.calendar }
    let(:parsed_json) { JSON.parse JSONFeed.from(calendar).to_s }

    before do
      Almanack.reset!
    end

    describe ".from" do
      around do |test|
        Timecop.freeze('2014-11-08 18:49:12 +1300', &test)
      end

      it "returns empty event sources by default" do
        expect(parsed_json).to eq({ "event_sources" => [] })
      end

      it "returns event sources" do
        Almanack.config.add_events [
          { title: "Basic event", start_time: Time.now }
        ]

        expect(parsed_json).to eq({
          "event_sources" => [
            {
              "events" => [
                {
                  "title" => "Basic event",
                  "start_time" => '2014-11-08 18:49:12 +1300'
                }
              ]
            }
          ]
        })
      end
    end

  end
end
