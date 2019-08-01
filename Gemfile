source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Ruby version
ruby '2.6.3'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use Puma as the app server
gem 'puma', '~> 3.11'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Pg is the Ruby interface to the PostgreSQL RDBMS
gem 'pg', '~> 1.1', '>= 1.1.4'

# Ordinare sorts gems in your Gemfile alphabetically
gem 'ordinare', '~> 0.4.0'

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]

  # rspec-rails is a testing framework for Rails 3+
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
end

group :test do
  # Strategies for cleaning databases. Can be used to ensure a clean state for testing.
  gem 'database_cleaner', '~> 1.7'

  # factory_bot_rails provides integration between factory_bot and rails 4.2 or newer
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'

  # provides RSpec- and Minitest-compatible one-liners to test common Rails functionality
  gem 'shoulda-matchers', '~> 4.1', '>= 4.1.2'

  # Code coverage for Ruby 1.9+
  gem 'simplecov', require: false
end

group :development do
  # Annotates Rails/ActiveRecord Models, routes, fixtures, and others based on the database schema.
  gem 'annotate', '~> 2.7', '>= 2.7.5'

  # help to kill N+1 queries and unused eager loading.
  gem 'bullet', '~> 6.0', '>= 6.0.1'

  gem 'listen', '>= 3.0.5', '< 3.2'

  # Automatic Ruby code style checking tool.
  gem 'rubocop', require: false

  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
