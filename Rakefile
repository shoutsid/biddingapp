# Add your own tasks in files placed in lib/tasks ending in .rake,
# for example lib/tasks/capistrano.rake, and they will automatically be available to Rake.

require File.expand_path('../config/application', __FILE__)

Bidding::Application.load_tasks
ENV['SKIP_AR_JDBC_RAKE_REDEFINES'] = '1'
