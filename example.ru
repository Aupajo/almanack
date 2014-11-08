require "bundler/setup"
require "almanack/server"

now = Time.now

Almanack.config do |calendar|
  calendar.title = 'Discworld Holidays'

  calendar.theme = 'starter'

  calendar.add_events [
    {
      title: "Hogswatch",
      start_time: now + Almanack::ONE_DAY,
      end_time: now + Almanack::ONE_DAY * 2,
      description: 'The sausages have been strung, the wreaths of oakleaves hung and the stockings dangled. The pork pie, the sherry and the all-important turnip await their festive guests. The poker lent against the fireplace may or may not have been bent over the head of some nightmare creature.',
      location: 'Castle of Bones'
    },
    { title: "Soul Cake Tuesday", start_time: now + 10 * Almanack::ONE_DAY },
    { title: "Eve of Small Gods", start_time: now + 30 * Almanack::ONE_DAY },
  ]
end

run Almanack::Server
