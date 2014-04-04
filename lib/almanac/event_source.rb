module Almanac
  class EventSource
    def initialize(events)
      @events = events
    end

    def events_between(date_range)
      @events.map { |attrs| Event.new(attrs) }
    end
  end
end