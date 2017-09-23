require "simplecov"

SimpleCov.start

require "bundler/setup"
require "teachable"
require "webmock/rspec"
require "pry"
require "vcr"

require_all "spec/support"

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new(SimpleCov::Formatter::HTMLFormatter)

RSpec.configure do |config|
  config.example_status_persistence_file_path = ".rspec_status"

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end

  config.around(:each) do |example|
    if example.metadata[:vcr]
      ENV["URI"] = "https://fast-bayou-75985.herokuapp.com"
      WebMock.enable!
      WebMock.reset!
      VCR.turn_on!
    else
      ENV["URI"] = nil
      WebMock.enable!
      VCR.turn_off!
    end

    example.run
  end
end
