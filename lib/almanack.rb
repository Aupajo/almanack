require "pathname"
require "json"
require "ri_cal"
require "addressable/uri"
require "faraday"

require "almanack/version"
require "almanack/configuration"
require "almanack/calendar"
require "almanack/event"
require "almanack/event_source/static"
require "almanack/event_source/meetup_group"
require "almanack/event_source/ical_feed"

module Almanack
  ONE_HOUR = 60 * 60
  ONE_DAY = 24 * ONE_HOUR
  ONE_MONTH = 30 * ONE_DAY
  ONE_YEAR = 365 * ONE_DAY

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
