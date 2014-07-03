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

    get "/stylesheets/:name" do
      # TODO make safe
      sass :"../stylesheets/#{params[:name]}"
    end
  end
end
