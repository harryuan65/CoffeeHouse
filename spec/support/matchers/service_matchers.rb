#
# Custom matchers for services
#
module ServiceMatchers
  RSpec::Matchers.define :match_result do |output, status, message|
    match do |actual|
      actual.output == output && actual.status == status && actual.message.match(/#{message}/)
    end
    failure_message do |actual|
      "expected result #{[actual.output, actual.status, actual.message]} to match #{[output, status, message || ""]}"
    end
  end
end
