require 'net/http'
require 'uri'
require 'ri_cal'

module Almanac
  class IcalFeed

    def initialize(url)
      @url = url
    end

    def events_between(date_range)
      occurrences_between(date_range).map do |occurrence|
        event_from(occurrence)
      end
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
      Event.new(title: occurrence.summary)
    end

    def entities
      RiCal.parse_string(body)
    end

    def body
      uri = URI(@url)
      Net::HTTP.get(uri)
    end

  end
end