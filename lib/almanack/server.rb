require "sinatra"
require "sinatra/reloader"

module Almanack
  class Server < Sinatra::Base
    configure :development do
      register Sinatra::Reloader
    end

    set :theme, 'origami'
    set :root, Pathname(settings.root).join('themes', settings.theme)

    get "/" do
      @calendar = Almanack.calendar
      erb :events
    end
  end
end