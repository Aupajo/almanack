require 'webmock/rspec'
require 'vcr'
require 'timecop'
require 'nokogiri'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']

require 'almanack'

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |file| require file }

RSpec.configure do |config|
  config.include ServerSupport, :feature
  config.include EventMatchers
  config.include TimeComparisonMatchers
end

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../fixtures/responses', __FILE__)
  config.ignore_hosts 'codeclimate.com'
  config.hook_into :webmock
end

WebMock.disable_net_connect!(:allow => "codeclimate.com")
