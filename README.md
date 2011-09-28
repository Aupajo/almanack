Sinatra GCal
============

**Note:** Hack and play, but beware: this is beta code.

Show off your Google Calendar in a nifty, Sinatra-powered events page.

![Sinatra GCal Example](http://imgur.com/odgyR.png)

See a demo running at [http://christchurch.events.geek.nz](http://christchurch.events.geek.nz)

Setting up
----------

Install requirements with `bundle install`.

Set your calendar in `config.yml' as needed. The calendar must be public.

Run with `ruby server.rb` (or `shotgun server.rb`).

Configuration
-------------

You can set the following in `config.yml`.

* `gcal` - the identifier for your public Google Calendar (can be found under calendar sharing options, often `xxxxx@group.calendar.google.com`)
* `lookahead` - how many days in the future you'd like to display (eg. `30`)
* `timezone` - a TZInfo-compatible timezone (eg. `UTC` or `Pacific/Auckland`)

Running Live
------------

A `config.ru` has been provided that should be enough to get you up-and-running in any environment. 


Laundry List
------------
Still marked TODO:

* Caching support (currently fetches the calendar every time a request is made)
* Tidy up the request code
