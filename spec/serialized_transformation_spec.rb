require 'spec_helper'

module Almanack
  describe SerializedTransformation do
    let(:fact_book) do
      {
        title: "Facts of the World",
        countries: [
          { name: "New Zealand", population: "4 mil" },
          { name: "America", population: "320 mil" }
        ]
      }
    end

    let(:transformation) { described_class.new(fact_book) }

    describe "#apply" do
      it "returns an unmodified structure by default" do
        expect(transformation.apply).to eq fact_book
      end

      it "can apply changes to keys" do
        transformation.key { |key| key.to_s }
        expect(transformation.apply).to eq({
          "title" => "Facts of the World",
          "countries" => [
            { "name" => "New Zealand", "population" => "4 mil" },
            { "name" => "America", "population" => "320 mil" }
          ]
        })
      end

      it "can apply changes to values" do
        transformation.value { |value| value.upcase  }
        expect(transformation.apply).to eq({
          title: "FACTS OF THE WORLD",
          countries: [
            { name: "NEW ZEALAND", population: "4 MIL" },
            { name: "AMERICA", population: "320 MIL" }
          ]
        })
      end
    end
  end
end
