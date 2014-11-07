require "sinatra"
require "sinatra/reloader"
require "sass"
require "almanack"

module Almanack
  class Server < Sinatra::Base
    require "almanack/server/helpers"

    configure :development do
      register Sinatra::Reloader
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

    def basename(file)
      Pathname(file).split.last.to_s.split(".", 2).first
    end

    def locate_asset(name, within: path)
      name = basename(name)
      path = settings.root.join(within)
      available = Pathname.glob(path.join("*"))
      asset = available.find { |path| basename(path) == name }
      raise "Could not find stylesheet #{name} inside #{available}" if asset.nil?
      asset
    end

    def auto_render_template(asset)
      renderer = asset.extname.split(".").last
      content = asset.read
      respond_to?(renderer) ? send(renderer, content) : content
    end

    def auto_render_asset(*args)
      auto_render_template locate_asset(*args)
    end

    def theme_stylesheet_path
      settings.root.join('stylesheets')
    end

    before do
      if !Sass.load_paths.include?(theme_stylesheet_path)
        Sass.load_paths << theme_stylesheet_path
      end
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
