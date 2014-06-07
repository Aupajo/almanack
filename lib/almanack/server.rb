require "sinatra"

module Almanack
  class Server < Sinatra::Base
    set :theme, 'origami'
    set :root, Pathname(settings.root).join('themes', settings.theme)

    get "/" do
      @calendar = Almanack.calendar
      erb :events
    end
  end
end