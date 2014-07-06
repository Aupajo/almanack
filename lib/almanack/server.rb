require "sinatra"
require "sass"
require "almanack"

module Almanack
  class Server < Sinatra::Base
    set :root, -> { Almanack.config.theme_root }
    set :protection, except: :frame_options

    get "/" do
      @calendar = Almanack.calendar
      erb :events
    end

    get "/feed.ics" do
      content_type "text/calendar"
      Almanack.calendar.ical_feed
    end

    get "/stylesheets/:name" do
      # TODO make safe
      sass :"../stylesheets/#{params[:name]}"
    end
  end
end
