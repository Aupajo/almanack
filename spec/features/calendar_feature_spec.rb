require 'spec_helper'

describe "Viewing a calendar", :feature do
  before { Almanack.reset! }

  it "displays all upcoming events" do
    now = Time.now

    Almanack.config.add_events [
      { title: "Hogswatch", start_date: now },
      { title: "Soul Cake Tuesday", start_date: now + 10 * 24 * 60 * 60 },
      { title: "Eve of Small Gods", start_date: now + 30 * 24 * 60 * 60 },
    ]

    Timecop.freeze(now) do
      get "/"
    end

    expect(last_response).to have_event_on_page("Hogswatch")
    expect(last_response).to have_event_on_page("Soul Cake Tuesday")
    expect(last_response).to have_event_on_page("Eve of Small Gods")
  end

  it "displays events from an iCal feed" do
    Almanack.config.add_ical_feed "https://www.google.com/calendar/ical/61s2re9bfk01abmla4d17tojuo%40group.calendar.google.com/public/basic.ics"

    Timecop.freeze(2014, 4, 3) do
      VCR.use_cassette('google_calendar') do
        get "/"
      end
    end

    expect(last_response).to have_event_on_page("Ruby Meetup @catalyst - Tanks! Guns!")
    expect(last_response).to have_event_on_page("The Foundation")
    expect(last_response).to have_event_on_page("WikiHouse/NZ weekly meet-up")
    expect(last_response).to have_event_on_page("Christchurch Python Meetup")
    expect(last_response).to have_event_on_page("Coffee & Jam")
  end

  it "allows being embedded in an iframe" do
    get "/"
    expect(last_response.headers).to_not have_key("X-Frame-Options")
  end
end
