require "pathname"
require "almanack/version"
require "almanack/server"
require "almanack/configuration"
require "almanack/calendar"
require "almanack/simple_event_collection"
require "almanack/meetup_group"
require "almanack/ical_feed"
require "almanack/event"

module Almanack
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