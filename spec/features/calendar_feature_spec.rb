require 'spec_helper'
require 'rack/test'

describe "Viewing a calendar" do
  include Rack::Test::Methods

  def app
    Almanac::Server
  end

  it "displays all upcoming events" do
    Almanac::EVENTS = [
      { title: "Hogswatch" },
      { title: "Soul Cake Tuesday" },
      { title: "Eve of Small Gods" },
    ]

    get "/"

    expect(last_response.errors).to be_empty
    expect(last_response.status).to eql(200)
    expect(last_response.body).to include("Hogswatch")
    expect(last_response.body).to include("Soul Cake Tuesday")
    expect(last_response.body).to include("Eve of Small Gods")
  end
end