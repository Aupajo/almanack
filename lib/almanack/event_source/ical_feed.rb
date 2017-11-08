module Almanack
  module EventSource
    class IcalFeed
      def initialize(url, options = {})
        @url = url
        @options = options
      end

      def events_between(date_range)
        occurrences_between(date_range).map do |occurrence|
          event_from(occurrence)
        end
      end

      def serialized_between(date_range)
        { events: events_between(date_range).map(&:serialized) }
      end

      private

      def each_ical_event(&block)
        entities.each do |entity|
          entity.events.each(&block) if entity.respond_to?(:events)
        end
      end

      def occurrences_between(date_range)
        to_date = date_range.max
        from_date = date_range.min

        occurrences = []

        each_ical_event do |ical_event|
          ical_event.occurrences(starting: from_date, before: to_date).each do |occurrence|
            occurrences << occurrence
          end
        end

        occurrences
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

      def entities
        RiCal.parse_string(response.body.force_encoding('UTF-8'))
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
