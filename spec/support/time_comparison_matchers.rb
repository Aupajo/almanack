module TimeComparisonMatchers
  extend RSpec::Matchers::DSL

  matcher :eq_time do |expected_time|
    match do |actual_time|
      actual_time.to_time.to_i == expected_time.to_time.to_i
    end

    failure_message do |actual_time|
      "expected #{actual_time.to_time} to be equal in time to #{expected_time.to_time}"
    end
  end

end
