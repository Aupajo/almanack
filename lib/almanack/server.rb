require "sinatra"

module Almanack
  class Server < Sinatra::Base
    set :theme, 'legacy'
    set :root, Pathname(settings.root).join('themes', settings.theme)

    get "/" do
      @calendar = Almanack.calendar
      erb :events
    end

    get "/stylesheets/:name" do
      sass :"stylesheets/#{params[:name]}"
    end
  end
end
