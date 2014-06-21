module Almanack
  class Calendar
    def initialize(config)
      @config = config
    end

    def event_sources
      @config.event_sources
    end

    def events
      from_date = DateTime.now
      to_date = DateTime.now + days_lookahead

      event_sources.map do |event_source|
        event_source.events_between(from_date..to_date)
      end.flatten.sort_by(&:start_date)
    end

    def days_lookahead
      30
    end
  end
end
