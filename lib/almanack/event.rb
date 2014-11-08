require 'ostruct'

module Almanack
  class Event < OpenStruct
    def formatted_date
      formatted = "#{formatted_day(start_time)} at #{formatted_time(start_time)}"

      if end_time
        formatted << " to "
        formatted << "#{formatted_day(end_time)} at " unless ends_on_same_day?
        formatted << formatted_time(end_time)
      end

      formatted
    end

    # Deprecated in favour of start_time
    def start_date
      deprecated :start_date, newer_method: :start_time
    end

    def start_time
      read_attribute :start_time, fallback: :start_date
    end

    # Deprecated in favour of end_time
    def end_date
      deprecated :end_date, newer_method: :end_time
    end

    def end_time
      read_attribute :end_time, fallback: :end_date
    end

    private

    def deprecated(older_method, options = {})
      newer_method = options.delete(:newer_method)
      value = read_attribute(newer_method, fallback: older_method)
      warn "Event method #{older_method} is deprecated; use #{newer_method} instead"
      value
    end

    def read_attribute(newer_method, options = {})
      fallback = options.delete(:fallback)
      
      if self[fallback] && self[newer_method]
        raise "Both #{fallback} and #{newer_method} properties are set, please use #{newer_method} only instead"
      elsif self[newer_method]
        self[newer_method]
      else
        warn "Deprecated event property #{fallback} is set; set #{newer_method} property instead"
        self[fallback]
      end
    end

    def ends_on_same_day?
      [start_time.year, start_time.yday] == [end_time.year, end_time.yday]
    end

    def formatted_time(time)
      time.strftime('%-l:%M%P')
    end

    def formatted_day(time)
      time.strftime('%B %-d %Y')
    end
  end
end
