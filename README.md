# Sinatra GCal

Show off your Google Calendar in a nifty, Sinatra-powered events page.

![Sinatra GCal example](http://i.imgur.com/odgyR.png)

See a demo running at [http://christchurch.events.geek.nz](http://christchurch.events.geek.nz)

Event descriptions can be formatted in [Markdown](http://daringfireball.net/projects/markdown/basics).

## Setting up a Sinatra GCal site

Sinatra GCal is designed to work out-of-the box on a single [Heroku](http://heroku.com/) dyno, effectively making it free to host.

With the [Heroku toolbelt](https://toolbelt.heroku.com/) installed, you can get up-and-running-with:

    heroku create --stack cedar
    heroku config:add GCAL_CALENDAR_ID=your-calendar-id@group.calendar.google.com
    heroku config:add TIMEZONE="Pacific/Auckland"
    git push heroku master
    heroku open

The two settings you must have are the `GCAL_CALENDAR_ID` and the `TIMEZONE`.

The `GCAL_CALENDAR ID` you can find on the Calendar Settings page:

![Choose "Calendar Settings" from the calendar options disclosure arrow](http://i.imgur.com/evQI5IX.png)

![Locate the Calendar ID](http://i.imgur.com/UN7d77t.png)

A list of available timezones can be found at https://gist.github.com/4654510

## Available settings

Options can be set via environment variables.

* `GCAL_CALENDAR_ID` -- Mandatory, the Google Calendar ID (see above)
* `TIMEZONE` -- Mandatory, the timezone in which to display the calendar
* `DAYS_LOOKAHEAD` -- Optional, how many days ahead to show (default is 30)
* `ALLOW_HTML` -- Optional, whether to allow HTML in event descriptions (default is false)

## Developing locally

Sinatra GCal is written in [Ruby](http://ruby-lang.org) (Ruby 1.9.3 recommended).

With [Bundler](http://gembundler.com) installed:

    bundle install

Ruby with `ruby server.rb`. If you want to reload the server each request (useful for development), install [Shotgun](http://rubygems.org/gems/shotgun) and run `shotgun server.rb`.

## Laundry list

Still to-do:

* Caching support (currently fetches the calendar every time a request is made)
* Tidy up the request code
