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
        Timecop.freeze(Time.now, &test)
      end

      it "returns empty event sources by default" do
        expect(parsed_json).to eq({ "eventSources" => [] })
      end

      it "returns event sources" do
        Almanack.config.add_events [
          { title: "Basic event", start_time: Time.now, custom_data: 'present' }
        ]

        expect(parsed_json).to eq({
          "eventSources" => [
            {
              "events" => [
                {
                  "title" => "Basic event",
                  "startTime" => Time.now.iso8601,
                  "customData" => 'present'
                }
              ]
            }
          ]
        })
      end
    end

  end
end
