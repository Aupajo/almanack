require "thor"
require "pathname"

module Almanack
  class CLI < Thor
    include Thor::Actions

    SKIP_THEMES = %w( starter )

    map "--version" => :version

    def self.available_themes
      dirs = Pathname(__dir__).join("themes").children.select(&:directory?)

      dirs.map do |path|
        path.basename.to_s unless SKIP_THEMES.include?(path.basename.to_s)
      end.compact
    end

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
    option :theme, default: 'legacy', desc: "Which theme to use (available: #{available_themes.join(', ')})"
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

    no_tasks do
      def theme
        options[:theme]
      end

      def available_themes
        self.class.available_themes
      end
    end

    def self.source_root
      Pathname(__dir__).parent.parent.join("templates")
    end
  end
end
