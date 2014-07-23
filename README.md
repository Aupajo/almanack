# Almanack

[![Build Status](https://travis-ci.org/Aupajo/almanack.svg)](https://travis-ci.org/Aupajo/almanack)
[![Code Climate](https://codeclimate.com/github/Aupajo/almanack.png)](https://codeclimate.com/github/Aupajo/almanack)
[![Code Climate](https://codeclimate.com/github/Aupajo/almanack/coverage.png)](https://codeclimate.com/github/Aupajo/almanack)

*This project was formerly Sinatra-GCal. A [legacy branch](https://github.com/Aupajo/almanack/tree/almanack) exists for that project.*

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

## Installation

Run the following command:

    gem install almanack

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
Almanack.config do |c|
  c.title = 'My Calendar'
  c.theme = 'my-custom-theme'
  c.add_ical_feed 'http://example.org/events.ics'
  c.add_ical_feed 'http://example.org/more-events.ics'
  c.add_meetup_group group_urlname: 'Christchurch-Ruby-Group', key: 'mysecretkey'
end
```

**Note:** You'll need your [Meetup.com API key](https://secure.meetup.com/meetup_api/key) to use Meetup.

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

With the [Heroku Toolbelt](https://toolbelt.heroku.com) installed:

    almanack deploy my-awesome-calendar

Will create and deploy http://my-awesome-calendar.herokuapp.com/.

Subsequent commits can be deployed with just:

    almanack deploy

## Contributing

1. Fork it ( http://github.com/Aupajo/almanack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
