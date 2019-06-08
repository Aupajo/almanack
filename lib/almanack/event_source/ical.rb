module Almanack
  module EventSource
    class Ical
      attr_reader :io

      def initialize(io)
        @io = io
      end

      def events_between(date_range)
        occurrences_between(date_range).map(&method(:event_from))
      end

      def serialized_between(date_range)
        { events: events_between(date_range).map(&:serialized) }
      end

      def self.from(*args)
        self.new(*args)
      end

      private

      def occurrences_between(date_range, &block)
        return enum_for(__method__, date_range) unless block_given?

        query = { starting: date_range.min, before: date_range.max }

        each_event do |ical_event|
          ical_event.occurrences(query).each(&block)
        end
      end

      def event_from(occurrence)
        Event.new(
          title: occurrence.summary,
          start_time: occurrence.dtstart,
          end_time: occurrence.dtend,
          description: occurrence.description,
          location: occurrence.location
        )
      end

      def read_io
        io.respond_to?(:read) ? io.read : io
      end

      def entities
        RiCal.parse_string(read_io)
      end

      def each_event(&block)
        entities.each do |entity|
          entity.events.each(&block) if entity.respond_to?(:events)
        end
      end
    end
  end
end
