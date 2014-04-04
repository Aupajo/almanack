require "pathname"
require "sinatra"
require "almanac/version"
require "almanac/server"
require "almanac/configuration"
require "almanac/ical_feed"

module Almanac
  def self.config
    @config ||= Configuration.new
  end

  def self.events
    config.events
  end

  def self.reset!
    config.reset!
  end
end