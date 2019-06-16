require 'almanack/server'

Almanack.config do |c|
  c.title = ENV.fetch('CALENDAR_NAME') { abort("No CALENDAR_NAME was specified.") }
  c.days_lookahead = 30

  # Don't fetch event information more than once every 15 minutes
  c.cache_responses = true

  c.cache_expiry = ENV.fetch('CACHE_DURATION_IN_SECONDS') { 900 }.to_i

  # Your group's URL name is what you'd find at www.meetup.com/Your-Group-URL-Name/
  # You can get a Meetup API key from https://secure.meetup.com/meetup_api/key

  meetup_api_keys = ENV.fetch('MEETUP_COM_API_KEYS', '').split(/[,\s]+/).cycle

  meetup_groups = ENV.fetch('MEETUP_COM_GROUPS', '').split(/\s+/)

  if meetup_groups.count > 0
    begin
      meetup_api_keys.peek
    rescue StopIteration
      abort "Meetup.com groups were specified but no MEETUP_COM_API_KEYS were set."
    end
  end

  meetup_groups.each do |group|
    group_urlname = URI.parse(group).path.delete('/')

    key = meetup_api_keys.next
    puts "Adding Meetup.com group #{group_urlname} with API key #{key}"
    c.add_meetup_group group_urlname: group_urlname, key: key
  end

  # For a Google Calendar, find the "iCal" link under your Calendar's settings
  ical_feeds = ENV.fetch('ICAL_FEEDS', '').split(/\s+/)

  ical_feeds.each do |url|
    puts "Added iCal feed #{url}"
    c.add_ical_feed url
  end

  if ical_feeds.empty? && meetup_groups.empty?
    c.add_events [
      {
        title: "Edit my calendar's settings",
        description: "Set the ICAL_FEEDS or MEETUP_COM_GROUPS environment variable to see some events.",
        start_time: Time.now + 30 * 60
      }
    ]
  end
end

run Almanack::Server
