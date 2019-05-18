
RSpec.describe "Consolidated iCal feed", :feature do
  let(:now) { Time.now }
  let(:parsed_feed) { RiCal.parse_string(Almanack.calendar.ical_feed) }
  let(:parsed_cal) { parsed_feed.first }
  let(:parsed_events) { parsed_cal.events }

  before do
    Timecop.freeze(now)

    Almanack.reset!

    Almanack.config.add_events [
      { title: "Basic", start_time: now },
      { title: "Almost a year away", start_time: now + 364 * 24 * 60 * 60 },
      { title: "Over a year away", start_time: now + 366 * 24 * 60 * 60 },
      {
        title: "Complex",
        start_time: now,
        end_time: now + 30 * 24 * 60 * 60,
        description: "Body",
        location: "CA"
      }
    ]
  end

  after { Timecop.return }

  it "should contain one calendar entity" do
    expect(parsed_feed.length).to eq(1)
    expect(parsed_feed.first).to be_an_instance_of(RiCal::Component::Calendar)
  end

  it "contains a year's worth of events" do
    expect(parsed_events.length).to eq(3)
    expect(parsed_events.map(&:summary)).to_not include("Over a year away")
  end

  it "contains all available event information" do
    complex_event = parsed_events.find { |e| e.summary == 'Complex' }
    expect(complex_event.dtstart).to eq_time(now)
    expect(complex_event.dtend).to eq_time(now + 30 * 24 * 60 * 60)
    expect(complex_event.description).to eq('Body')
    expect(complex_event.location).to eq('CA')
  end

  it "treats missing end dates as three hours from the start date" do
    three_hours_from_now = now + 3 * 60 * 60
    basic_event = parsed_events.find { |e| e.summary == 'Basic' }
    expect(basic_event.dtend).to eq_time(three_hours_from_now)
  end

  it "can be accessed from the server" do
    allow(Almanack.calendar).to receive(:ical_feed) { "feed" }
    get "/feed.ics"
    expect(last_response.body).to eq("feed")
    expect(last_response.headers["Content-Type"]).to include("text/calendar")
  end

  it "constructs a feed URL based on the scheme, host, port and settings" do
    random_port = rand(2048..9999)
    random_domain = "calendar#{rand(1..99)}.example.org"
    random_path = "/custom/#{rand(1..99)}/feed"
    scheme = %i( http https ).sample

    original_feed_path = app.settings.feed_path
    app.settings.feed_path = random_path

    get("/", nil,
      'HTTP_HOST' => random_domain,
      'SERVER_PORT' => random_port,
      'HTTPS' => (scheme == :https ? 'on' : 'off')
    )

    expect(last_response.body)
      .to include("#{scheme}://#{random_domain}:#{random_port}#{random_path}.ics")

    app.settings.feed_path = original_feed_path
  end

  it "has a sensible default for an HTTP feed URL" do
    get("/", nil, 'HTTPS' => 'off', 'SERVER_PORT' => '80')
    expect(last_response.body).to include("http://example.org/feed.ics")
  end

  it "has a sensible default for an HTTPS feed URL" do
    get("/", nil, 'HTTPS' => 'on', 'SERVER_PORT' => '443')
    expect(last_response.body).to include("https://example.org/feed.ics")
  end
end
