require 'forwardable'

module Almanack
  class Calendar
    ONE_HOUR = 60 * 60
    ONE_DAY = 24 * ONE_HOUR
    ONE_MONTH = 30 * ONE_DAY
    ONE_YEAR = 365 * ONE_DAY

    extend Forwardable
    def_delegators :@config, :event_sources, :title, :days_lookahead

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
        event_source.events_between(date_range)
      end.flatten

      event_list.sort_by do |event|
        event.start_date.to_time
      end
    end

    def ical_feed
      now = Time.now
      future = now + ONE_YEAR

      # Three hours is the duration for events missing end dates, a
      # recommendation suggested by Meetup.com.
      three_hours = 3 * ONE_HOUR

      ical = RiCal.Calendar

      events_between(now..future).each do |event|
        ical_event = RiCal.Event
        ical_event.summary = event.title
        ical_event.dtstart = event.start_date.utc
        ical_event.dtend = (event.end_date || event.start_date + three_hours).utc
        ical_event.description = event.description if event.description
        ical_event.location = event.location if event.location

        ical.add_subcomponent(ical_event)
      end

      ical.to_s
    end
  end
end
