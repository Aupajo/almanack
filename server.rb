require 'sinatra'
require 'tzinfo'
require 'net/http'
require 'uri'
require 'ri_cal'

# TODO: move to external config
set :gcal, "61s2re9bfk01abmla4d17tojuo@group.calendar.google.com"
set :lookahead, 30 # days
set :timezone, TZInfo::Timezone.get('Pacific/Auckland')

helpers do
  def format_time_range(start_time, end_time)
    output = format_time(start_time)
    output << " &mdash; #{format_time(end_time)}" unless end_time.nil?
    output << ", #{to_timezone(start_time).strftime('%d %b %Y')}"
  end
  
  def format_time(datetime)
    to_timezone(datetime).strftime('%I:%M%p')
  end
  
  def to_timezone(datetime)
    options.timezone.utc_to_local(datetime.new_offset(0))
  end
  
  def gcal_url
    "http://www.google.com/calendar/ical/#{options.gcal}/public/basic.ics"
  end
  
  def gcal_feed_url
    "http://www.google.com/calendar/feeds/#{options.gcal}/public/basic"
  end
  
  alias_method :h, :escape_html
end

# TODO: Add caching support

get '/' do
  # TODO: Tidy, separate out, error handling support
  ical_string = Net::HTTP.get URI.parse(gcal_url)
  components = RiCal.parse_string ical_string
  @calendar = components.first
  @calendar_name = @calendar.x_properties['X-WR-CALNAME'].first.value
  occurrences = @calendar.events.map do |e|
    # TODO: support timezone
    e.occurrences(:starting => Date.today, :before => Date.today + options.lookahead)
  end
  @events = occurrences.flatten.sort { |a,b| a.start_time <=> b.start_time }
  haml :events
end

get '/stylesheet.css' do
  content_type 'text/css'
  sass :stylesheet
end
