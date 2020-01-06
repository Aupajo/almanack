module Almanack
  module Representation
    class IcalFeed
      attr_reader :calendar

      def initialize(calendar)
        @calendar = calendar
      end

      def ical
        @ical ||= ical_calendar
      end

      def to_s
        ical.to_ical
      end

      def self.from(calendar)
        self.new(calendar)
      end

      private

      def events
        calendar.events_between(now..lookahead)
      end

      def ical_calendar
        events.each_with_object(Icalendar::Calendar.new) do |event, calendar|
          calendar.add_event ical_event_for(event)
        end
      end

      def ical_event_for(event)
        BuiltIcalEvent.for(event)
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
