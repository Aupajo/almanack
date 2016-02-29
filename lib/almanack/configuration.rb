module Almanack
  class Configuration
    class ThemeNotFound < StandardError; end

    CACHE_DIR = "tmp"
    DEFAULT_THEME = "legacy"
    DEFAULT_DAYS_LOOKAHEAD = 30
    DEFAULT_FEED_LOOKAHEAD = 365
    DEFAULT_CACHE_RESPONSES = false
    DEFAULT_CACHE_EXPIRY = 900

    attr_reader :event_sources
    attr_accessor :title,
                  :theme,
                  :theme_paths,
                  :theme_root,
                  :days_lookahead,
                  :feed_lookahead,
                  :cache_responses,
                  :cache_expiry

    def initialize
      reset!
    end

    def connection
      @connection ||= Faraday.new do |conn|
        conn.use FaradayMiddleware::FollowRedirects
        conn.response(:caching) { cache_store } if cache_responses
        conn.adapter Faraday.default_adapter
      end
    end

    def reset!
      @theme           = DEFAULT_THEME
      @days_lookahead  = DEFAULT_DAYS_LOOKAHEAD
      @feed_lookahead  = DEFAULT_FEED_LOOKAHEAD
      @event_sources   = []
      @cache_responses = DEFAULT_CACHE_RESPONSES
      @cache_expiry    = DEFAULT_CACHE_EXPIRY

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

    def add_event_source(source)
      @event_sources << source
    end

    def add_ical_feed(url)
      add_event_source EventSource::IcalFeed.new(url, connection: connection)
    end

    def add_events(events)
      add_event_source EventSource::Static.new(events)
    end

    def add_meetup_group(options)
      add_event_source EventSource::MeetupGroup.new(options.merge(connection: connection))
    end

    def cache_store
      @cache_store ||= ActiveSupport::Cache::FileStore.new(cache_dir, expires_in: cache_expiry)
    end

    private

    def cache_dir
      Pathname.pwd.join(CACHE_DIR)
    end
  end
end
