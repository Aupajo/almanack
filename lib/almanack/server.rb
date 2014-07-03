require "sinatra"
require "almanack"

module Almanack
  class Server < Sinatra::Base
    set :theme, Almanack.config.theme
    set :root, Pathname(settings.root).join('themes', settings.theme)
    set :protection, except: :frame_options

    get "/" do
      @calendar = Almanack.calendar
      erb :events
    end

    get "/stylesheets/:name" do
      sass :"stylesheets/#{params[:name]}"
    end
  end
end
