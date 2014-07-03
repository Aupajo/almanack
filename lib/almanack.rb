require "pathname"
require "almanack/version"
require "almanack/configuration"
require "almanack/calendar"
require "almanack/simple_event_collection"
require "almanack/meetup_group"
require "almanack/ical_feed"
require "almanack/event"

module Almanack
  class << self
    def config(&block)
      @config ||= Configuration.new
      yield @config if block_given?
      @config
    end

    def calendar
      @calendar ||= Calendar.new(config)
    end

    def reset!
      config.reset!
    end
  end
end
