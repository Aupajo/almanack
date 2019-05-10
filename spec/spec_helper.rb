require 'webmock/rspec'
require 'vcr'
require 'timecop'
require 'nokogiri'

require 'almanack'

Dir[File.expand_path('../support/*.rb', __FILE__)].each { |file| require file }

RSpec.configure do |config|
  config.include ServerSupport, :feature
  config.include EventMatchers
  config.include TimeComparisonMatchers

  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!
end

VCR.configure do |config|
  config.cassette_library_dir = File.expand_path('../fixtures/responses', __FILE__)
  config.hook_into :webmock
end

WebMock.disable_net_connect!
