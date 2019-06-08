# Almanack

[![Build Status](https://travis-ci.org/Aupajo/almanack.svg)](https://travis-ci.org/Aupajo/almanack)
[![Gem Version](https://badge.fury.io/rb/almanack.svg)](http://badge.fury.io/rb/almanack)

A calendar that combines events from different sources (such as Google Calendar, Meetup.com, and iCal feeds), and can be hosted for free on [Heroku](http://heroku.com).

![Sinatra GCal example](http://i.imgur.com/odgyR.png)

See a demo running at [http://christchurch.events.geek.nz](http://christchurch.events.geek.nz)

## Features

* Aggregate multiple calendars together into one stream
* Supports iCal feeds (incuding Google Calendars)
* Supports Meetup.com groups
* Just supply a hash to create any arbitrary event
* Supports being freely hosted on Heroku
* 100% customisable themes with Sass and CoffeeScript support
* Server optional (you can use the underlying calendar library by itself)
* Rack-compatible (can be mounted inside a Rails app if needed)
* Produces iCal feed for smartphone and desktop calendar apps to subscribe to

## Video tutorial

[![View on YouTube](http://i.imgur.com/4ifJAXD.jpg)](http://youtu.be/0tUcWHE0Zh0)

## Installation

Almanack is cryptographically signed. You can install it like any other gem, but you can also do so in a way that verifies the gem hasn't been tampered with.

Add my public key (if you haven’t already) as a trusted certificate:

    gem cert --add <(curl -Ls https://raw.github.com/aupajo/almanack/master/certs/aupajo.pem)

Then install the gem:

    gem install almanack -P HighSecurity

All my dependencies are cryptographically signed, so you can use the `HighSecurity` option. [Read more](http://docs.seattlerb.org/rubygems/Gem/Security.html).

Checksums for released gems can be found in `checksums`.

## Creating a calendar

Generate a new calendar with:

    almanack new my-calendar

This will create a directory called `my-calendar` and set up your new project.

Once set up, run:

    cd my-calendar
    almanack start

By default, your calendar will run on http://localhost:9292.

## Configuration

See examples inside `config.ru` for iCal feeds, Meetup.com, or static events.

```ruby
Almanack.config do |config|
  config.title = 'My Calendar'
  config.theme = 'my-custom-theme'
  config.days_lookahead = 30

  # Combine sources from multiple iCal feeds
  config.add_ical_feed 'http://example.org/events.ics'
  config.add_ical_feed 'http://example.org/more-events.ics'

  # Include a downloaded iCal
  config.add_ical Pathname('downloaded-calendar.ical')

  # Include Meetup events
  config.add_meetup_group group_urlname: 'Christchurch-Ruby-Group', key: 'mysecretkey'
end
```

**Note:** You'll need your [Meetup.com API key](https://secure.meetup.com/meetup_api/key) to use Meetup.

### Time zone

To set your time zone, set your system's `TZ` environment variable.

```bash
TZ=Pacific/Auckland
```

On Heroku, you can do this with:

    heroku config:set TZ=Pacific/Auckland

## Custom themes

Inside your project, you can generate a new theme with:

    almanack theme my-theme-name

Remember to update your `config.ru` to switch themes:

```ruby
Almanack.config do |c|
  ...
  c.theme = 'my-theme-name'
  ...
end
```

## Deploying to Heroku

Deployment works with Git and Heroku. First, add your work to git (an repository
is already initialized for you when you run `almanack new`):

    git add .
    git commit -m "My awesome calendar"

With the [Heroku CLI](https://devcenter.heroku.com/articles/heroku-cli) installed:

    almanack deploy my-awesome-calendar

Will create and deploy http://my-awesome-calendar.herokuapp.com/.

Subsequent commits can be deployed with just:

    almanack deploy

## Contributing

### Getting started

1. Clone the repository
2. Run `bin/setup`
3. Run `bin/test`

### Sending patches

1. Fork it ( http://github.com/Aupajo/almanack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`) with tests
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
