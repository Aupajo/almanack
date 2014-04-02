module Almanac
  class Server < Sinatra::Base
    get "/" do
      @events = Almanac::EVENTS
      erb :events
    end
  end
end