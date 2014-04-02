module Almanac
  class Server < Sinatra::Base
    get "/" do
      Almanac::EVENTS.map { |e| e[:title] }
    end
  end
end