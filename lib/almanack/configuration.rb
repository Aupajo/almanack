require 'net/http'
require 'uri'
require 'ri_cal'
require 'sass'
require 'cachy'
require 'moneta'

module Almanack
  class Configuration
    class ThemeNotFound < StandardError; end

    DEFAULT_THEME = "legacy"
    DEFAULT_DAYS_LOOKAHEAD = 30

    attr_reader :event_sources
    attr_accessor :title, :theme, :theme_paths, :theme_root, :days_lookahead

    def initialize
      reset!
    end

    def reset!
      @theme = DEFAULT_THEME
      @days_lookahead = DEFAULT_DAYS_LOOKAHEAD
      @event_sources = []

      @theme_paths = [
        Pathname.pwd.join('themes'),
        Pathname(__dir__).join('themes')
      ]
      Cachy.cache_store = cache
    end

    def theme_root
      paths = theme_paths.map { |path| path.join(theme) }
      root = paths.find { |path| path.exist? }
      root || raise(ThemeNotFound, "Could not find theme #{theme} in #{paths}")
    end

    def theme=(theme)
      @theme = theme
      Sass.load_paths << theme_root.join('stylesheets')
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

    def cache
      @cache ||= Moneta.new(:LRUHash)
    end
  end
end
