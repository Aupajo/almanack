module Almanack
  module Representation
    class JSONFeed
      def self.from(calendar)
        {}.to_json
      end
    end
  end
end
