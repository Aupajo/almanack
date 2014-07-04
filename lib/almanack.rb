require "pathname"
require "almanack/version"
require "almanack/configuration"
require "almanack/calendar"
require "almanack/event"
require "almanack/event_source/static"
require "almanack/event_source/meetup_group"
require "almanack/event_source/ical_feed"

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
