require 'spec_helper'

describe "Consolidated iCal feed" do
  let(:now) { Time.now }
  let(:parsed_feed) { RiCal.parse_string(Almanack.calendar.ical_feed) }
  let(:parsed_cal) { parsed_feed.first }
  let(:parsed_events) { parsed_cal.events }

  before do
    Timecop.freeze(now)

    Almanack.reset!

    Almanack.config.add_events [
      { title: "Basic", start_date: now },
      { title: "Almost a year away", start_date: now + 364 * 24 * 60 * 60 },
      { title: "Over a year away", start_date: now + 366 * 24 * 60 * 60 },
      {
        title: "Complex",
        start_date: now,
        end_date: now + 30 * 24 * 60 * 60,
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

end
