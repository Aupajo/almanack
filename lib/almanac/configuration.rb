require 'net/http'
require 'uri'
require 'ri_cal'

module Almanac
  class Configuration    
    def initialize
      reset!
    end

    def reset!
      @event_sources = []
    end

    def add_ical_feed(url)
      @event_sources << IcalFeed.new(url)
    end

    def add_events(events)
      @event_sources << EventSource.new(events)
    end

    def events  
      days_lookahead = 30
      from_date = DateTime.now
      to_date = DateTime.now + days_lookahead
      
      @event_sources.map do |event_source|
        event_source.events_between(from_date..to_date)
      end.flatten.sort_by(&:start_date)
    end
  end
end