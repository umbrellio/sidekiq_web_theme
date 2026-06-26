# frozen_string_literal: true

require "simplecov"
require "simplecov-lcov"

SimpleCov::Formatter::LcovFormatter.config do |config|
  config.report_with_single_file = true
  config.single_report_path = "coverage/lcov.info"
end

SimpleCov.formatter = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::LcovFormatter,
])

SimpleCov.start { add_filter "spec" }

$LOAD_PATH.unshift(File.expand_path("../lib", __dir__))

require "sidekiq_web_theme"

RSpec.configure do |config|
  config.expect_with(:rspec) { |c| c.syntax = :expect }
  config.disable_monkey_patching!
end
