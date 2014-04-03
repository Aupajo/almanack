require 'net/http'
require 'uri'
require 'ri_cal'

module Almanac
  class Configuration    
    def initialize
      reset!
    end

    def reset!
      @simple_events = []
      @ical_feeds = []
    end

    def add_ical_feed(url)
      @ical_feeds << url
    end

    def add_events(events)
      @simple_events << events
    end

    def events  
      days_lookahead = 30
      from_date = DateTime.now
      to_date = DateTime.now + days_lookahead
      occurrences = []

      @ical_feeds.each do |feed_url|
        url = URI(feed_url)
        body = Net::HTTP.get(url)
        ical_entities = RiCal.parse_string(body)

        ical_entities.each do |entity|
          if entity.respond_to?(:events)
            occurrences << entity.events.map do |event|
              event.occurrences(starting: from_date, before: to_date).map do |occurrence|
                { title: occurrence.summary }
              end
            end
          end
        end
      end

      (@simple_events + occurrences).flatten
    end
  end
end