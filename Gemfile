source 'https://rubygems.org'

gem 'rails', '4.0.0.rc1'
gem 'pg'

gem 'json', '~> 1.7.7'
gem 'sass-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
#gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'
gem 'turbo-sprockets-rails3', group: :assets

gem 'foreman'
gem 'puma'
gem 'figaro'
gem 'resque', :require=> 'resque/server'
gem 'cancan', :github => 'moriz/cancan' 
gem 'devise', git: 'git://github.com/plataformatec/devise.git', branch: 'rails4'
gem 'bootstrap-sass', '~> 2.3.1.0'
gem 'stringex', git: 'git://github.com/rsl/stringex.git'
gem 'time_difference'

group :test, :development do
  gem 'guard'
  gem 'rb-inotify', '~> 0.9'
  gem 'factory_girl_rails', '~> 4.0'
end

group :development do
  gem 'guard-livereload'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard-rspec'
  gem 'parallel_tests'
  gem 'zeus-parallel_tests'
end

group :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'ruby-prof'
  gem 'shoulda-matchers'
  gem 'database_cleaner', git: 'git://github.com/bmabey/database_cleaner.git'
end

gem 'capistrano'
gem 'rvm-capistrano'
