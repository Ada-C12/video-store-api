ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/autorun'
require 'minitest/reporters'

Minitest::Reporters.use! Minitest::Reporters::SpecReporter.new

CUSTOMER_KEYS = ["address", "city", "id", "movies_checked_out_count", "name", "phone", "postal_code", "registered_at", "state"].sort 
RENTAL_KEYS = ["id", "checkout_date", "due_date", "movie_id", "customer_id"].sort
MOVIE_KEYS = ["id", "title", "overview", "release_date", "inventory", "available_inventory"].sort

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  fixtures :all
  
  # Add more helper methods to be used by all tests here...
end
