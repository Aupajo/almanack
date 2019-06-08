module Almanack
  module EventSource
    class IcalFeed
      extend Forwardable

      attr_reader :ical, :connection

      def_delegators :ical, :events_between, :serialized_between

      def initialize(url, connection:)
        @url = url
        @connection = connection
      end

      def ical
        @ical ||= Ical.from(response.body)
      end

      private

      def uri
        Addressable::URI.parse(@url)
      end

      def response
        connection.get(uri)
      end

    end
  end
end
