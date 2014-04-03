module Almanac
  class Server < Sinatra::Base
    set :theme, 'origami'
    set :root, Pathname(settings.root).join('themes', settings.theme)

    get "/" do
      @events = Almanac.events
      erb :events
    end
  end
end