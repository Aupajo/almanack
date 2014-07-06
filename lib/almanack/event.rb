require 'ostruct'

module Almanack
  class Event < OpenStruct
    def formatted_date
      formatted = "#{formatted_day(start_date)} at #{formatted_time(start_date)}"

      if end_date
        formatted << " to "
        formatted << "#{formatted_day(end_date)} at " unless ends_on_same_day?
        formatted << formatted_time(end_date)
      end

      formatted
    end

    private

    def ends_on_same_day?
      [start_date.year, start_date.yday] == [end_date.year, end_date.yday]
    end

    def formatted_time(time)
      time.strftime('%-l:%M%P')
    end

    def formatted_day(time)
      time.strftime('%B %-d %Y')
    end
  end
end
