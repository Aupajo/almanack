fixture_helpers = Module.new do
  def fixture_path(*path)
    Pathname(__dir__).parent.join('fixtures', *path)
  end

  def read_fixture(*args)
    fixture_path(*args).read
  end
end

RSpec.configure do |config|
  config.include fixture_helpers
end
