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

      def calendar
        @calendar ||= Almanack.calendar
      end

      def page_title(separator: " – ")
        [@title, calendar.title].compact.join(separator)
      end

      def title(value)
        @title = value
      end
    end

    not_found do
      status 404
      erb :error
    end

    get "/" do
      erb :events
    end

    get "/#{settings.feed_path}" do
      content_type "text/calendar"
      Almanack.calendar.ical_feed
    end

    get "/stylesheets/:name" do
      path = Pathname("..").join("stylesheets", params[:name])
      scss path.to_s.to_sym
    end
  end
end
