require "sinatra"
require "sinatra/reloader"
require "sass"
require "almanack"

module Almanack
  class Server < Sinatra::Base
    require "almanack/server/helpers"
    require "almanack/server/environment"

    include Almanack::ServerContext::Environment

    configure :development do
      register Sinatra::Reloader
    end

    helpers do
      include Almanack::ServerContext::Helpers
    end

    set :root, -> { Almanack.config.theme_root }
    set :protection, except: :frame_options
    set :feed_path, "feed"

    not_found do
      status 404
      erb :error
    end

    error do
      status 500
      erb :error
    end

    before do
      register_sass_loadpaths!
    end

    get "/" do
      erb :events
    end

    get "/#{settings.feed_path}.ics" do
      content_type "text/calendar"
      Almanack.calendar.ical_feed
    end

    get "/stylesheets/:name" do
      content_type :css
      auto_render_asset params[:name], within: "stylesheets"
    end

    get "/javascripts/:name" do
      content_type :js
      auto_render_asset params[:name], within: "javascripts"
    end
  end
end
