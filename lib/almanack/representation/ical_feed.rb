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
        ical.to_s
      end

      def self.from(calendar)
        self.new(calendar)
      end

      private

      def events
        calendar.events_between(now..lookahead)
      end

      def ical_calendar
        events.each_with_object(RiCal.Calendar) do |event, calendar_component|
          calendar_component.add_subcomponent ical_event_for(event)
        end
      end

      def ical_event_for(event)
        ical_event = RiCal.Event
        ical_event.summary = event.title
        if event.start_time.is_a?(DateTime)
          ical_event.dtstart = event.start_time.new_offset('+00:00')
        elsif event.start_time.is_a?(Time)
          ical_event.dtstart = event.start_time.utc
        end
        if (event.end_time.present? && event.end_time.is_a?(DateTime)) || event.start_time.is_a?(DateTime)
          ical_event.dtend = (event.end_time || event.start_time + default_event_duration ).new_offset('+00:00')
        elsif (event.end_time.present? && event.end_time.is_a?(Time)) || event.start_time.is_a?(Time)
          ical_event.dtend = (event.end_time || event.start_time + default_event_duration ).utc
        end
        ical_event.description = event.description if event.description
        ical_event.location = event.location if event.location
        ical_event
      end

      def lookahead
        now + calendar.feed_lookahead * ONE_DAY
      end

      def default_event_duration
        # Three hours is the duration for events missing end dates, a
        # recommendation suggested by Meetup.com.
        3 * ONE_HOUR
      end

      def now
        @now ||= Time.now
      end
    end
  end
end
