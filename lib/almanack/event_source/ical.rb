module Almanack
  module EventSource
    class Ical
      attr_reader :io

      def initialize(io)
        @io = io
      end

      def events_between(date_range)
        return enum_for(__method__, date_range).to_a unless block_given?

        from, to = [date_range.min, date_range.max]

        each_ical_event do |ical_event|
          if ical_event.rrule.empty?
            ical_event.dtend = ical_event.dtend||end_time_from_duration(ical_event)

            if from < ical_event.dtend
              yield event_from(ical_event)
            end
          else
            ical_event.occurrences_between(from, to).each do |occurrence|
              yield event_from(ical_event, occurrence: occurrence)
            end
          end
        end
      end

      def serialized_between(date_range)
        { events: events_between(date_range).map(&:serialized) }
      end

      def self.from(*args)
        self.new(*args)
      end

      private

      def end_time_from_duration(ical_event)
        start = ical_event.dtstart
        start += ical_event.duration.weeks.send('weeks')
        start += ical_event.duration.days.send('days')
        start += ical_event.duration.hours.send('hours')
        start += ical_event.duration.minutes.send('minutes')
        start += ical_event.duration.seconds.send('seconds')
      end

      def event_from(ical_event, occurrence: nil)
        Event.new(
          title: ical_event.summary,
          start_time: occurrence&.start_time || ical_event.dtstart,
          end_time: occurrence&.end_time || ical_event.dtend,
          description: ical_event.description,
          location: ical_event.location
        )
      end

      def read_io
        io.respond_to?(:read) ? io.read : io
      end

      def each_ical_event(&block)
        Icalendar::Calendar.parse(read_io).each do |calendar|
          calendar.events.each(&block)
        end
      end
    end
  end
end
