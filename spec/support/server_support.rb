require 'rack/test'

module ServerSupport
  include Rack::Test::Methods

  def app
    Almanack::Server
  end
end