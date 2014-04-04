require 'almanac'
require 'webmock/rspec'
require 'vcr'
require 'timecop'
require 'nokogiri'
require 'codeclimate-test-reporter'

CodeClimate::TestReporter.start if ENV['CODECLIMATE_REPO_TOKEN']

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |file| require file }

RSpec.configure do |config|
  # Will be the default in RSpec 3
  config.treat_symbols_as_metadata_keys_with_true_values = true

  config.include ServerSupport, :feature
end

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../fixtures/responses', __FILE__)
  config.hook_into :webmock
end
