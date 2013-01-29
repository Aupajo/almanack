require 'bundler/setup'

require 'sinatra'
require 'tzinfo'
require 'net/http'
require 'uri'
require 'ri_cal'
require 'yaml'
require 'rdiscount'

configure do
  config_file = File.join(File.dirname(__FILE__), 'config.yml')
  config = {}
  
  if File.exists?(config_file)
    warn "Warning: config.yml is deprecated, and will be removed in a future version of Sinatra GCal. Refer to the README on how to use environment variables instead."
    config = YAML.load_file(config_file)
  end
  
  set :gcal, ENV['GCAL_CALENDAR_ID'] || config['gcal']
  set :days_lookahead, (ENV['DAYS_LOOKAHEAD'] || config['lookahead'] || 30).to_i
  set :timezone, TZInfo::Timezone.get(ENV['TIMEZONE']) || config['timezone']
  set :allow_html, (ENV['ALLOW_HTML'] || false)
  set :twitter, ENV['TWITTER']
end

helpers do
  def format_time_range(start_time, end_time)
    output = format_time(start_time)
    output << " &mdash; #{format_time(end_time)}" unless end_time.nil?
    output << ", #{to_timezone(start_time).strftime('%d %b %Y')}"
  end
  
  def markdown(text)
    content = settings.allow_html ? text : escape_html(text)
    RDiscount.new(content).to_html
  end
  
  def format_time(datetime)
    to_timezone(datetime).strftime('%I:%M%p')
  end
  
  def to_timezone(datetime)
    settings.timezone.utc_to_local(datetime.new_offset(0))
  end
  
  def to_timezone_date(datetime)
    current = to_timezone(datetime)
    Date.new(current.year, current.month, current.day)
  end
  
  def gcal_url
    "http://www.google.com/calendar/ical/#{settings.gcal}/public/basic.ics"
  end
  
  def gcal_feed_url
    "http://www.google.com/calendar/feeds/#{settings.gcal}/public/basic"
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
  @today = to_timezone_date(DateTime.now)
  occurrences = @calendar.events.map do |e|
    e.occurrences(:starting => @today, :before => @today + settings.days_lookahead)
  end
  @events = occurrences.flatten.sort { |a,b| a.start_time <=> b.start_time }
  erb :events
end

get '/stylesheet.css' do
  content_type 'text/css'
  sass :stylesheet
end
