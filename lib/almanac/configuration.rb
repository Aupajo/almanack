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
      @ical_feeds << IcalFeed.new(url)
    end

    def add_events(events)
      @simple_events << events
    end

    def events  
      days_lookahead = 30
      from_date = DateTime.now
      to_date = DateTime.now + days_lookahead
      
      occurrences = []
      occurrences << @ical_feeds.map { |feed| feed.events_between(from_date, to_date) }
      occurrences << @simple_events
      occurrences.flatten
    end
  end
end