module Almanack
  module EventSource
    class Static
      def initialize(events)
        @event_attrs = events
      end

      def events_between(date_range)
        events.select do |event|
          event.start_date >= date_range.min && event.start_date <= date_range.max
        end
      end

      private

      def events
        @events ||= @event_attrs.map do |attrs|
          Event.new(attrs)
        end
      end
    end
  end
end
