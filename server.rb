require 'sinatra'
require 'ri_cal'

set :lookahead, 30 # days

helpers do
  def show_if_available(event, *properties)
    properties.map do |prop|
      next if event.send(prop).empty?
      "<div class='#{prop.to_s}'>#{event.send(prop)}</div>"
    end
  end
end

get '/' do
  ical_string = IO.read 'basic.ics'
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

__END__

@@ events
!!! 5
%html
  %head
    %title Events
    %link{ :href => '/stylesheet.css', :rel => 'stylesheet', :type => 'text/css', :media => 'screen', :charset => 'utf-8' }
  %body
    %header
      %h1 #{@calendar_name}
      %h2 The Next #{options.lookahead} Days
    -for event in @events
      .event
        .date
          .month=event.start_time.strftime '%b'
          .day=event.start_time.strftime '%d'
        .details
          %h3=event.summary
          =show_if_available event, :description, :location

@@ stylesheet

body
  background-color: #e3e3e3
  color: #595959
  font: 12pt/1.6em "Helvetica Neue", Helvetica, sans-serif
  margin: 2em auto
  width: 600px

.event
  background: -webkit-gradient(linear, left top, left bottom, from(#f9f9f9), to(#efefef))
  border-top: 1px solid white
  border-radius: 4px
  overflow: hidden
  padding: 20px
  margin-bottom: 1em
  -webkit-box-shadow: 0 1px 3px rgba(0,0,0,0.3)
  
  .details
    float: right
    width: 480px
  
  .location
    font-size: 0.9em

header
  border-bottom: 1px solid #ccc
  overflow: hidden
  padding-bottom: 0.5em
  margin-bottom: 1em
  -webkit-box-shadow: 0 1px 0 #f6f6f6

h1, h2, h3
  margin: 0
  text-shadow: 0 1px 0 white

h1
  color: #666
  font-size: 1.8em
  float: left

h2
  color: #999
  font-size: 1em
  float: right
  text-transform: uppercase

.date
  background-color: #c00
  border-radius: 4px
  color: white
  float: left
  text-align: center
  padding: 2px
  width: 60px
  
  .day
    background-color: white
    color: #333
    font-size: 1.6em
    padding: 0.2em
