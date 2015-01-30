require 'forwardable'

module Almanack
  class Calendar
    extend Forwardable
    def_delegators :@config, :event_sources,
                             :title,
                             :days_lookahead,
                             :feed_lookahead

    def initialize(config)
      @config = config
    end

    def events
      now = Time.now
      future = now + days_lookahead * ONE_DAY
      events_between(now..future)
    end

    def events_between(date_range)
      event_list = event_sources.map do |event_source|
        Thread.new { event_source.events_between(date_range) }
      end.map(&:value).flatten

      event_list.sort_by do |event|
        event.start_time.to_time
      end
    end

    def ical_feed
      Representation::IcalFeed.from(self).to_s
    end

    def json_feed
      Representation::JSONFeed.from(self).to_s
    end
  end
end
