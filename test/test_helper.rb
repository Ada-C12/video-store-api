ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require_relative '../config/environment'
require 'rails/test_help'
# require 'simplecov'
# SimpleCov.start do
#   add_filter 'test/'
# end
require 'minitest'
require 'minitest/autorun'
require 'minitest/reporters'
require 'minitest/rails'
require 'minitest/pride'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
