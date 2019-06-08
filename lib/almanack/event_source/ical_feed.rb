module Almanack
  module EventSource
    class IcalFeed
      attr_reader :ical

      def initialize(url, options = {})
        @url = url
        @options = options
      end

      def events_between(date_range)
        ical.occurrences_between(date_range).map(&method(:event_from))
      end

      def serialized_between(date_range)
        { events: events_between(date_range).map(&:serialized) }
      end

      private

      def event_from(occurrence)
        Event.new(
          title: occurrence.summary,
          start_time: occurrence.dtstart,
          end_time: occurrence.dtend,
          description: occurrence.description,
          location: occurrence.location
        )
      end

      def ical
        @ical ||= Ical.from(response.body)
      end

      def connection
        @options[:connection]
      end

      def response
        uri = Addressable::URI.parse(@url)
        connection.get(uri)
      end

    end
  end
end
