require 'sinatra'

set :environment, :production
disable :run

require 'haml'
require 'server'

run Sinatra::Application