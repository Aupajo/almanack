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
    option :git, type: :boolean, default: true, desc: "Whether to initialize an empty git repo"
    def new(path)
      path = Pathname(path).cleanpath

      directory "templates/new", path

      if options[:git]
        template('templates/gitignore', path.join(".gitignore"))
      end

      inside path do
        say_status :installing, "bundler dependencies"
        system "bundle install --quiet"

        if options[:git]
          say_status :git, "initializing repository"
          git "init"
        end

        say
        say "==> Run your new calendar!"
        say
        say "  cd #{path}"
        say "  almnack start"
        say
      end
    end

    desc "theme NAME", "Create a new theme"
    def theme(name)
      directory "lib/almanack/themes/starter", "themes/#{name}"

      config_file = Pathname("config.ru")

      if config_file.exist?
        say_status :update, "config.ru"
        set_theme_pattern = /\.theme\s*=\s*['"].*?['"]/
        replacement = config_file.read.gsub(set_theme_pattern, ".theme = '#{name}'")
        config_file.open('w') { |file| file.puts replacement }
      end
    end

    desc "deploy [NAME]", "Deploy your site to Heroku (requires Heroku toolbelt)"
    def deploy(name = nil)
      remotes = `git remote -v`

      heroku_remote = remotes.lines.find do |remote|
        remote.split(' ').first == "heroku"
      end

      if !heroku_remote
        say "No Heroku remote detected."
        create_heroku_app(name)
      end

      current_branch = git("rev-parse --abbrev-ref HEAD")

      say "Deploying #{current_branch}..."
      run "git push heroku #{current_branch}:master --force"
    end

    no_tasks do
      def create_heroku_app(name)
        heroku_command = `which heroku`.strip

        if heroku_command.empty?
          say "Heroku Toolbelt not detected. Please install from:"
          say "  https://toolbelt.heroku.com"
          abort
        end

        say_status :heroku, "creating app..."
        run "#{heroku_command} create #{name}"
      end

      def theme_name
        options[:theme]
      end

      def git(command)
        output = `git #{command}`
        abort "Git failed: #{output}" if $?.exitstatus != 0
        output.strip
      end

      def available_themes
        self.class.available_themes
      end
    end

    def self.exit_on_failure?
      true
    end

    def self.source_root
      Pathname(__dir__).parent.parent
    end
  end
end
