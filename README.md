Sinatra GCal
============

**Note:** Hack and play, but beware: this is alpha code.

Show off your Google Calendar in a nifty, Sinatra-powered events page.

See a demo running at [http://christchurch.events.geek.nz](http://christchurch.events.geek.nz)

Setting up
----------

Install requirements with `bundle install`.

Copy `config.example.yml` to `config.yml`, adjust as you need.

Run with `ruby server.rb` (or `shotgun server.rb`).

Configuration
-------------

You can set the following in `config.yml`.

* `gcal` - the identifier for your public Google Calendar (can be found under calendar sharing options, often `xxxxx@group.calendar.google.com`)
* `lookahead` - how many days in the future you'd like to display (eg. `30`)
* `timezone` - a TZInfo-compatible timezone (eg. `UTC` or `Pacific/Auckland`)

Running Live
------------

If you're using Passenger, a `config.ru` like this will do nicely:

    require 'rubygems'
    require 'sinatra'

    set :environment, :production
    disable :run

    require 'haml'
    require 'server'

    run Sinatra::Application
    

Laundry List
------------
Still marked TODO:

* Caching support (currently fetches the calendar every time a request is made)
* Tidy up the request code
