### Unreleased

* Upgrade Rake dependency to ~> 13

### 2020-02-25, Version 1.3.1

* Security update: upgrade Nokogiri to 1.10.8 to address [CVE-2020-7595](https://nvd.nist.gov/vuln/detail/CVE-2020-7595)

### 2020-01-07, Version 1.3.0

* [#42](https://github.com/Aupajo/almanack/pull/42) Replace [RiCal](https://github.com/rubyredrick/ri_cal) with [icalendar](https://github.com/icalendar/icalendar) to support the extended RFC 5455 calendar standard

### 2020-01-07, Version 1.2.1

* [#41](https://github.com/Aupajo/almanack/pull/41) Replace defunct [ruby-sass](https://github.com/sass/ruby-sass) with [sassc](https://rubygems.org/gems/sassc)

### 2019-11-23, Version 1.2.0

* [#38](https://github.com/Aupajo/almanack/issues/38) Remove Meetup support (see [#36](https://github.com/Aupajo/almanack/issues/36) for rationale)

### 2019-11-23, Version 1.1.5

* [#37](https://github.com/Aupajo/almanack/issues/37) Deprecate Meetup support (see [#36](https://github.com/Aupajo/almanack/issues/36) for rationale)

### 2019-08-22, Version 1.1.4

* Security update: upgrade Nokogiri 1.10.4 to address CVE-2019-11068

### 2019-06-15, Version 1.1.3

* Handle full-day events
* Add support for iCal files and IO

### 2019-05-18, Version 1.1.2

* Strip unnecessary port numbers from `feed_url`

### 2019-05-11, Version 1.1.1

* Align Almanack with `bundle gem` defaults

### 2019-04-18, Version 1.1.0

* Parallelized event source retrieval (large speed-up for configurations with many calendars)
* Ruby 2.6 support
* Improved Unicode handling
* Expose a JSON API

### 2014-10-25, Version 1.0.5

* Remove references to earlier Sinatra-Gcal project

### 2014-08-11, Version 1.0.4

* Use Faraday for requests
* Add a `now` helper method for templates

### 2014-07-29, Version 1.0.3

* Fix for `.sass-cache`

### 2014-07-27, Version 1.0.2

* Support `@import` in Sass

### 2014-07-23, Version 1.0.1

* Support Meetup events without locations
* Support Ruby 2.0 and 2.1
* Custom lookahead

### 2014-07-19, Version 1.0.0

* Initial release
