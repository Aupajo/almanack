require 'net/http'
require 'json'
require 'addressable/uri'

module Almanac
  class MeetupGroup
    def initialize(options = {})
      @request_options = options
    end

    def events_between(date_range)
      events.select do |event|
        event.start_date >= date_range.min && event.start_date <= date_range.max
      end
    end

    private

    def events
      request = MeetupAPIRequest.new(@request_options)
      request.results.map { |result| event_from(result) }
    end

    def event_from(result)
      # 3 hours, as recommended by Meetup.com if duration isn't present
      default_duration_in_ms = 3 * 60 * 60 * 1000
      
      event_name = [result['group']['name'], result['name']].compact.join(': ')
      start_time = Time.at(result['time'] / 1000)
      duration_in_secs = (result['duration'] || default_duration_in_ms) / 1000
      end_time = start_time + duration_in_secs
      
      Event.new(
        title: event_name,
        start_date: start_time.to_datetime,
        end_date: end_time.to_datetime,
        description: result['description'],
        location: location_from_venue(result['venue']),
        url: result['event_url']
      )
    end

    def location_from_venue(venue)
      %w{ name address_1 address_2 address_3 city state country }.map do |attr|
        venue[attr]
      end.compact.join(', ')
    end
  end

  class MeetupAPIError < StandardError
  end

  class MeetupAPIException < Exception
  end

  class MeetupAPIRequest
    REQUIRED_OPTIONS = [:group_domain, :group_urlname, :group_id]

    attr_accessor :options

    def initialize(options = {})
      @options = options
    end

    def results
      response['results']
    end

    def uri
      if !options.has_key?(:key)
        raise MeetupAPIException, 'Cannot form valid URI, missing :key option'
      end

      if (options.keys & REQUIRED_OPTIONS).empty?
        raise MeetupAPIException, "Cannot form valid URI, missing one of: #{REQUIRED_OPTIONS}"
      end

      endpoint = "https://api.meetup.com/2/events"

      Addressable::URI.parse(endpoint).tap do |uri|
        uri.query_values = options
      end
    end

    def response
      json = Net::HTTP.get(uri)
      data = JSON.parse(json)
      
      if data['problem']
        raise MeetupAPIError, data['problem']
      end

      data
    end
  end
end