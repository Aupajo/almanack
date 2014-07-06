require 'forwardable'

module Almanack
  class Calendar
    extend Forwardable
    def_delegators :@config, :event_sources, :title

    def initialize(config)
      @config = config
    end

    def events
      now = DateTime.now
      future = now + days_lookahead
      events_between(now..future)
    end

    def events_between(date_range)
      event_sources.map do |event_source|
        event_source.events_between(date_range)
      end.flatten.sort_by(&:start_date)
    end

    def days_lookahead
      30
    end
  end
end
