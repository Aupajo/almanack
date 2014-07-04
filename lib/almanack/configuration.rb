require 'net/http'
require 'uri'
require 'ri_cal'

module Almanack
  class Configuration
    class ThemeNotFound < StandardError; end

    DEFAULT_THEME = "legacy"

    attr_reader :event_sources
    attr_accessor :title, :theme, :theme_paths, :theme_root

    def initialize
      reset!
    end

    def reset!
      @theme = DEFAULT_THEME
      @event_sources = []

      @theme_paths = [
        Pathname.pwd.join('themes'),
        Pathname(__dir__).join('themes')
      ]
    end

    def theme_root
      paths = theme_paths.map { |path| path.join(theme) }
      root = paths.find { |path| path.exist? }
      root || raise(ThemeNotFound, "Could not find theme #{theme} in #{paths}")
    end

    def add_ical_feed(url)
      @event_sources << EventSource::IcalFeed.new(url)
    end

    def add_events(events)
      @event_sources << EventSource::Static.new(events)
    end

    def add_meetup_group(options)
      @event_sources << EventSource::MeetupGroup.new(options)
    end
  end
end
