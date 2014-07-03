require "bundler/setup"
require "rack/reloader"
require "almanack"

today = DateTime.now

Almanack.config do |calendar|
  calendar.title = 'Discworld Holidays'

  calendar.add_events [
    {
      title: "Hogswatch",
      start_date: today,
      description: 'The sausages have been strung, the wreaths of oakleaves hung and the stockings dangled. The pork pie, the sherry and the all-important turnip await their festive guests. The poker lent against the fireplace may or may not have been bent over the head of some nightmare creature.',
      location: 'Castle of Bones'
    },
    { title: "Soul Cake Tuesday", start_date: today + 10 },
    { title: "Eve of Small Gods", start_date: today + 30 },
  ]
end

run Almanack::Server
