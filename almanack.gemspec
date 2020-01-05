# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "almanack/version"

Gem::Specification.new do |spec|
  spec.name          = "almanack"
  spec.version       = Almanack::VERSION
  spec.authors       = ["Pete Nicholls"]
  spec.email         = ["aupajo@gmail.com"]
  spec.summary       = %q{Combined events calendar for Google Calendar, iCal, and friends.}
  spec.homepage      = Almanack::HOMEPAGE
  spec.license       = "MIT"

  # Gem signing
  spec.cert_chain    = ['certs/aupajo.pem']
  spec.signing_key = File.expand_path("~/.ssh/gem-private_key.pem") if $0 =~ /gem\z/

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end

  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "sinatra"
  spec.add_dependency "sinatra-contrib"
  spec.add_dependency "sassc"
  spec.add_dependency "ri_cal"
  spec.add_dependency "addressable"
  spec.add_dependency "thor"
  spec.add_dependency "faraday"
  spec.add_dependency "faraday_middleware"
  spec.add_dependency "rack-contrib"
  spec.add_dependency "activesupport"

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "rack-test"
  spec.add_development_dependency "webmock"
  spec.add_development_dependency "vcr"
  spec.add_development_dependency "timecop"
  spec.add_development_dependency "nokogiri"
  spec.add_development_dependency "bundler-audit"
end
