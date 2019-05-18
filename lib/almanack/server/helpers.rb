module Almanack
  module ServerContext
    module Helpers
      # @return The URL to your consolidated iCal feed.
      def feed_url
        File.join(request.base_url, "#{settings.feed_path}.ics")
      end

      # @return The URL to Almanack's project homepage.
      def almanack_project_url
        Almanack::HOMEPAGE
      end

      # @return The URL to Almanack's issues page.
      def almanack_issues_url
        Almanack::ISSUES
      end

      # @return The current time.
      def now
        Time.now
      end

      # @return The calendar.
      def calendar
        @calendar ||= Almanack.calendar
      end

      # @return The title of the page.
      def page_title(separator: " – ")
        [@title, calendar.title].compact.join(separator)
      end

      # Use to set the title of the page.
      def title(value)
        @title = value
      end
    end
  end
end
