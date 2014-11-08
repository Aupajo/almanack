module Almanack
  module Representation
    class JSONFeed
      attr_reader :calendar

      def initialize(calendar)
        @calendar = calendar
      end

      def to_s
        json_friendly = SerializedTransformation.new(serialized)
        json_friendly.key { |key| camelize(key.to_s) }
        json_friendly.apply.to_json
      end

      def self.from(calendar)
        self.new(calendar)
      end

      private

      def camelize(string)
        string.split('_').map.with_index do |part, index|
          index.zero? ? part : part.capitalize
        end.join
      end

      def date_range
        now..lookahead
      end

      def serialized
        { event_sources: serialized_event_sources }
      end

      def serialized_event_sources
        event_sources.map do |source|
          source.serialized_between(date_range)
        end
      end

      def event_sources
        calendar.event_sources
      end

      def lookahead
        now + calendar.feed_lookahead * ONE_DAY
      end

      def now
        @now ||= Time.now
      end
    end
  end
end
