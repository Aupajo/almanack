require 'net/http'
require 'uri'
require 'ri_cal'

module Almanack
  class Configuration
    DEFAULT_THEME = "legacy"

    attr_reader :event_sources
    attr_accessor :title, :theme

    def initialize
      reset!
    end

    def reset!
      @theme = DEFAULT_THEME
      @event_sources = []
    end

    def add_ical_feed(url)
      @event_sources << IcalFeed.new(url)
    end

    def add_events(events)
      @event_sources << SimpleEventCollection.new(events)
    end

    def add_meetup_group(options)
      @event_sources << MeetupGroup.new(options)
    end
  end
end
