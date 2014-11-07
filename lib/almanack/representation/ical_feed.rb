module Almanack
  module Representation
    class IcalFeed
      attr_reader :calendar

      def initialize(calendar)
        @calendar = calendar
      end

      def ical
        @ical ||= begin
          ical_component = RiCal.Calendar

          calendar.events_between(now..lookahead).each do |event|
            ical_event = RiCal.Event
            ical_event.summary = event.title
            ical_event.dtstart = event.start_date.utc
            ical_event.dtend = (event.end_date || event.start_date + default_event_duration ).utc
            ical_event.description = event.description if event.description
            ical_event.location = event.location if event.location

            ical_component.add_subcomponent(ical_event)
          end

          ical_component
        end
      end

      def to_s
        ical.to_s
      end

      def self.from(calendar)
        self.new(calendar).to_s
      end

      private

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
