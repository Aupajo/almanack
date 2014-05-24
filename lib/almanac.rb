require "pathname"
require "almanac/version"
require "almanac/server"
require "almanac/configuration"
require "almanac/calendar"
require "almanac/simple_event_collection"
require "almanac/meetup_group"
require "almanac/ical_feed"
require "almanac/event"

module Almanac
  def self.config
    @config ||= Configuration.new
  end

  def self.calendar
    @calendar ||= Calendar.new(config)
  end

  def self.reset!
    config.reset!
  end
end