module Almanack
  module Representation
    class JSONFeed
      attr_reader :calendar

      def initialize(calendar)
        @calendar = calendar
      end

      def to_s
        to_hash.to_json
      end

      def self.from(calendar)
        self.new(calendar).to_s
      end

      private

      def to_hash
        {}
      end
    end
  end
end
