require "thor"

module Almanack
  class CLI < Thor
    include Thor::Actions
    map "--version" => :version

    desc "version", "Show Almanack version"
    def version
      say "Almanack version #{VERSION} (#{CODENAME})"
    end

    desc "start", "Start an Almanack server"
    option :config, aliases: "-c", desc: "Path to config file"
    def start
      exec "bundle exec rackup #{options[:config]}"
    end

    desc "new PATH", "Create a new Almanack project"
    def new(path)
      path = Pathname(path).cleanpath
      directory "new", path

      inside path do
        say_status :run, "bundle install"
        system "bundle install --quiet"
        say
        say "==> Run your new calendar!"
        say
        say "  cd #{path}"
        say "  almnack start"
        say
      end
    end

    def self.source_root
      Pathname(__dir__).parent.parent.join("templates")
    end
  end
end
