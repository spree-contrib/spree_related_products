require 'simplecov'
SimpleCov.start do
  add_filter 'spec'
  add_group  'Controllers', 'app/controllers'
  add_group  'Overrides', 'app/overrides'
  add_group  'Models', 'app/models'
  add_group  'Libraries', 'lib'
end

ENV['RAILS_ENV'] ||= 'test'

begin
  require File.expand_path('../dummy/config/environment', __FILE__)
rescue LoadError
  puts 'Could not load dummy application. Please ensure you have run `bundle exec rake test_app`'
  exit
end

require 'rspec/rails'
require 'shoulda/matchers'
require 'ffaker'
require 'pry'
require 'versioncake/version'

RSpec.configure do |config|
  config.fail_fast = false
  config.filter_run focus: true
  config.run_all_when_everything_filtered = true
  config.raise_errors_for_deprecations!
  config.infer_spec_type_from_file_location!

  config.expect_with :rspec do |expectations|
    expectations.syntax = :expect
  end

  if VersionCake::VERSION >= '3'
    config.include VersionCake::TestHelpers, type: :controller
    config.before(:each, type: :controller) do
      set_request_version('', 1)
    end
  end

  config.order = :random
end

Dir[File.join(File.dirname(__FILE__), 'support/**/*.rb')].each { |file| require file }
