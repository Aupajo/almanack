require 'sinatra'
require 'net/http'
require 'uri'
require 'ri_cal'

set :gcal, "61s2re9bfk01abmla4d17tojuo@group.calendar.google.com"
set :lookahead, 30 # days

get '/' do
  ical_string = Net::HTTP.get URI.parse("http://www.google.com/calendar/ical/#{options.gcal}/public/basic.ics")
  components = RiCal.parse_string ical_string
  @calendar = components.first
  @calendar_name = @calendar.x_properties['X-WR-CALNAME'].first.value
  occurrences = @calendar.events.map {|e| e.occurrences(:starting => Date.today, :before => Date.today + options.lookahead) }
  @events = occurrences.flatten.sort { |a,b| a.start_time <=> b.start_time }
  haml :events
end

get '/stylesheet.css' do
  content_type 'text/css'
  sass :stylesheet
end
