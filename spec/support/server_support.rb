require 'rack/test'
require 'almanack/server'

module ServerSupport
  include Rack::Test::Methods

  def app
    Almanack::Server
  end
end
