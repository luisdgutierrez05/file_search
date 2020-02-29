# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

# Ruby version
ruby '2.6.3'

# ActiveModel::Serializers allows you to generate your JSON in an object-oriented and convention-driven manner.
gem 'active_model_serializers', '~> 0.10.10'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false

# Ordinare sorts gems in your Gemfile alphabetically
gem 'ordinare', '~> 0.4.0'

# Pg is the Ruby interface to the PostgreSQL RDBMS
gem 'pg', '~> 1.1', '>= 1.1.4'

# Use Puma as the app server
gem 'puma', '~> 3.12'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 5.2.3'

# provides a simple API for performing paginated queries with Active Record
gem 'will_paginate', '~> 3.1', '>= 3.1.7'

group :development, :test do
  # Debugger console
  gem 'byebug', platforms: %i[mri mingw x64_mingw]

  # rspec-rails is a testing framework for Rails 3+
  gem 'rspec-rails', '~> 3.8', '>= 3.8.2'
end

group :test do
  # Strategies for cleaning databases.
  gem 'database_cleaner', '~> 1.7'

  # provides integration between factory_bot and rails 4.2 or newer
  gem 'factory_bot_rails', '~> 5.0', '>= 5.0.2'

  # provides one-liners to test common Rails functionality.
  gem 'shoulda-matchers', '~> 4.1', '>= 4.1.2'
end

group :development do
  # Annotates Rails/ActiveRecord Models, routes, fixtures, etc.
  gem 'annotate', '~> 2.7', '>= 2.7.5'

  gem 'listen', '>= 3.0.5', '< 3.2'

  # Automatic Ruby code style checking tool.
  gem 'rubocop', require: false

  # speeds up development by keeping your application running in the background.
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
