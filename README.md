Sinatra GCal
============

**Note:** Hack and play, but beware: this is alpha code.

Show off your Google Calendar in a nifty, Sinatra-powered events page.

See a demo running at [http://christchurch.events.geek.nz](http://christchurch.events.geek.nz)

Configuration
-------------

You can set the following in `config.yml`.

* `gcal` - the identifier for your public Google Calendar (can be found under calendar sharing options, often `xxxxx@group.calendar.google.com`)
* `lookahead` - how many days in the future you'd like to display (eg. `30`)
* `timezone` - a TZInfo-compatible timezone (eg. `UTC` or `Pacific/Auckland`)

Laundry List
------------
Still marked TODO:

* Caching support (currently fetches the calendar every time a request is made)
* Tidy up the request code
