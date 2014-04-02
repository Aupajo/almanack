require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Run a dummy server'
task :server do
  require "almanac"

  Almanac::EVENTS = [
    { title: "Hogswatch" },
    { title: "Soul Cake Tuesday" },
    { title: "Eve of Small Gods" },
  ]

  Rack::Handler::WEBrick.run(Almanac::Server)
end