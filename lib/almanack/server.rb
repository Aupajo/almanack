require "sinatra"
require "sass"
require "almanack"

module Almanack
  class Server < Sinatra::Base
    set :root, -> { Almanack.config.theme_root }
    set :protection, except: :frame_options
    set :feed_path, "feed.ics"

    helpers do
      def feed_url
        "webcal://#{request.host}:#{request.port}/#{settings.feed_path}"
      end
    end

    get "/" do
      @calendar = Almanack.calendar
      erb :events
    end

    get "/#{settings.feed_path}" do
      content_type "text/calendar"
      Almanack.calendar.ical_feed
    end

    get "/stylesheets/:name" do
      # TODO make safe
      sass :"../stylesheets/#{params[:name]}"
    end
  end
end
