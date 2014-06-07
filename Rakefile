require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

task :default => :spec

desc 'Run a dummy server'
task :server do
  require "almanack"

  today = DateTime.now

  Almanack.config.add_events [
    { title: "Hogswatch", start_date: today },
    { title: "Soul Cake Tuesday", start_date: today + 10 },
    { title: "Eve of Small Gods", start_date: today + 30 },
  ]

  Rack::Handler::WEBrick.run(Almanack::Server)
end