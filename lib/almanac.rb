require "almanac/version"

module Almanac
  class Server
    def self.call(env)
      status = 200
      headers = {}
      body = Almanac::EVENTS.map { |e| e[:title] }

      [status, headers, body]
    end
  end
end
