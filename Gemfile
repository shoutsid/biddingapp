source 'https://rubygems.org'

gem 'rails', '4.0.0.rc1'

gem 'time_difference'

gem 'sqlite3'
gem 'sass-rails', '~> 4.0.0.rc1'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'
gem 'therubyracer', platforms: :ruby
gem 'jquery-rails'
#gem 'turbolinks'
gem 'jbuilder', '~> 1.0.1'

group :doc do
  # bundle exec rake doc:rails generates the API under doc/api.
  gem 'sdoc', require: false
end

gem 'devise', git: 'git://github.com/plataformatec/devise.git', branch: 'rails4'
gem 'puma'

gem 'bootstrap-sass', '~> 2.3.1.0'

gem 'stringex', git: 'git://github.com/rsl/stringex.git'

group :test, :development do
  gem 'guard'
  gem 'rb-inotify', '~> 0.9'
  gem 'factory_girl_rails', '~> 4.0'
end

group :development do
  gem 'guard-rspec'
  gem 'guard-livereload'
  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'parallel_tests'
  gem 'zeus-parallel_tests'
end

group :test do
  gem 'rspec-rails', '~> 2.0'
  gem 'ruby-prof'
  gem 'shoulda-matchers'
  gem 'zeus'
  gem 'database_cleaner', git: 'git://github.com/bmabey/database_cleaner.git'
end
