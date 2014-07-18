require "sinatra"
require "sinatra/reloader"
require "sass"
require "almanack"

module Almanack
  class Server < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    set :root, -> { Almanack.config.theme_root }
    set :protection, except: :frame_options
    set :feed_path, "feed.ics"

    helpers do
      def feed_url
        "webcal://#{request.host}:#{request.port}/#{settings.feed_path}"
      end

      def almanack_project_url
        Almanack::HOMEPAGE
      end

      def almanack_issues_url
        Almanack::ISSUES
      end
    end

    get "/" do
      erb :events, locals: { calendar: Almanack.calendar }
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
