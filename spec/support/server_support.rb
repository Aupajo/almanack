require 'rack/test'

module ServerSupport
  include Rack::Test::Methods

  def app
    Almanac::Server
  end
end