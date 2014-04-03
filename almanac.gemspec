# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'almanac/version'

Gem::Specification.new do |spec|
  spec.name          = "almanac"
  spec.version       = Almanac::VERSION
  spec.authors       = ["Pete Nicholls"]
  spec.email         = ["pete@metanation.com"]
  spec.summary       = %q{TODO: Write a short summary. Required.}
  spec.description   = %q{TODO: Write a longer description. Optional.}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "ri_cal"

  spec.add_development_dependency "bundler", "~> 1.5"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "nokogiri"
end
