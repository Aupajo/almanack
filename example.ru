require "bundler/setup"
require "rack/reloader"
require "almanack"

today = DateTime.now

Almanack.config.add_events [
  { title: "Hogswatch", start_date: today },
  { title: "Soul Cake Tuesday", start_date: today + 10 },
  { title: "Eve of Small Gods", start_date: today + 30 },
]

run Almanack::Server
