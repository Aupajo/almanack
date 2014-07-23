# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'almanack/version'

Gem::Specification.new do |spec|
  spec.name          = "almanack"
  spec.version       = Almanack::VERSION
  spec.authors       = ["Pete Nicholls"]
  spec.email         = ["pete@metanation.com"]
  spec.summary       = %q{Combined events calendar for Google Calendar, iCal, Meetup.com and friends.}
  spec.homepage      = Almanack::HOMEPAGE
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "sinatra-contrib"
  spec.add_dependency "sass"
  spec.add_dependency "ri_cal"
  spec.add_dependency "addressable"
  spec.add_dependency "thor"
  spec.add_dependency "cachy"
  spec.add_dependency "moneta"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "codeclimate-test-reporter"
end
