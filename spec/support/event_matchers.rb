RSpec::Matchers.define :have_event do |title|
  match do |response|
    raise response.errors if !response.errors.empty?

    doc = Nokogiri::HTML(response.body)
    
    @titles = doc.css('.event').map { |e| e.text.strip }
    @titles.any? { |t| t == title.strip }
  end

  failure_message_for_should do |response|
    "expected to see an event named #{title.inspect}, got #@titles"
  end
end