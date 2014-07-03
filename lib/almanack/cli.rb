require "thor"

module Almanack
  class CLI < Thor
    include Thor::Actions
    map "--version" => :version

    desc "version", "Show Almanack version"
    def version
      say "Almanack version #{VERSION} (#{CODENAME})"
    end

  end
end
