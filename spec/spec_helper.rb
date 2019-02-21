require "bundler/setup"
require "firefighter"
require "timecop"
require 'vcr'
require_relative 'support/credentials'

VCR.configure do |config|
  config.cassette_library_dir = "spec/support/cassettes"
  config.hook_into :webmock # or :fakeweb
  config.default_cassette_options = { record: :new_episodes }
end

RSpec.configure do |config|
  # Enable flags like --only-failures and --next-failure
  config.example_status_persistence_file_path = ".rspec_status"

  # Disable RSpec exposing methods globally on `Module` and `main`
  config.disable_monkey_patching!

  config.expect_with :rspec do |c|
    c.syntax = :expect
  end
end
