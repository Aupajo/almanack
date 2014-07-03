# Almanack

[![Build Status](https://travis-ci.org/Aupajo/sinatra-gcal.svg)](https://travis-ci.org/Aupajo/sinatra-gcal)
[![Code Climate](https://codeclimate.com/github/Aupajo/sinatra-gcal.png)](https://codeclimate.com/github/Aupajo/sinatra-gcal)
[![Code Climate](https://codeclimate.com/github/Aupajo/sinatra-gcal/coverage.png)](https://codeclimate.com/github/Aupajo/sinatra-gcal)

A calendar that combines events from different sources (such as Google Calendar, Meetup.com, and iCal feeds), and can be hosted for free on [Heroku](http://heroku.com).

## Installation

Run the following command:

    gem install almanack --pre

## Creating a calendar

Generate a new calendar with:

    almanack new my-calendar

This will create a directory called `my-calendar` and set up your new project.

Once set up, run:

    cd my-calendar
    almanack start

By default, your calendar will run on http://localhost:9292.

## Configuring

See examples inside `config.ru` for iCal feeds, Meetup.com, or static events.

### Meetup.com

You'll need your [Meetup.com API key](https://secure.meetup.com/meetup_api/key).

## Contributing

1. Fork it ( http://github.com/Aupajo/almanack/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
