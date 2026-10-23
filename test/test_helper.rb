ENV["RAILS_ENV"] ||= "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'

class ActiveSupport::TestCase
  begin
    ActiveRecord::Migration.check_all_pending!
  rescue ActiveRecord::NoDatabaseError, PG::Error
    ActiveRecord::Tasks::DatabaseTasks.prepare_all
    ActiveRecord::Migration.check_all_pending!
  end

  # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  fixtures :all

  # Add more helper methods to be used by all tests here...
end
