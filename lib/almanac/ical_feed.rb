require 'net/http'
require 'uri'
require 'ri_cal'

module Almanac
  class IcalFeed

    def initialize(url)
      @url = url
    end

    def events_between(date_range)
      to_date = date_range.max
      from_date = date_range.min

      occurrences = []

      entities.each do |entity|
        if entity.respond_to?(:events)
          occurrences << entity.events.map do |event|
            event.occurrences(starting: from_date, before: to_date).map do |occurrence|
              event_from(occurrence)
            end
          end
        end
      end

      occurrences.flatten
    end

    private

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