module EventMatchers
  extend RSpec::Matchers::DSL

  matcher :have_event do |title = nil, attrs = {}|
    match do |events|
      attrs[:title] = title if title

      events.any? do |event|
        attrs.all? { |k,v| event.send(k) == v }
      end
    end

    failure_message_for_should do |events|
      "expected to see an event with #{attrs.inspect}, saw #{events.inspect}"
    end
  end

  matcher :all_have_properties do |*properties|
    match do |collection|
      collection.all? do |obj|
        properties.all? { |p| !obj.send(p).nil? }
      end
    end

    failure_message_for_should do |events|
      "expected to all events to have properites #{properties.inspect}"
    end
  end

  matcher :be_in_order do
    match do |events|
      events == events.sort_by(&:start_date)
    end

    failure_message_for_should do |events|
      "expected to events to be in order"
    end
  end

  matcher :have_event_on_page do |title|
    match do |response|
      raise response.errors if !response.errors.empty?

      doc = Nokogiri::HTML(response.body)
      
      @titles = doc.css('.event .title').map { |e| e.text.strip }
      @titles.any? { |t| t == title.strip }
    end

    failure_message_for_should do |response|
      "expected to see an event named #{title.inspect}, got #@titles"
    end
  end
end