source 'https://rubygems.org'

gem 'rails' # , github: 'rails/rails'

# Use sqlite3 as the database for Active Record
gem 'sqlite3'

# Use SCSS for stylesheets
gem 'sass-rails'

# Use Uglifier as compressor for JavaScript assets
gem 'uglifier'

# Use CoffeeScript for .js.coffee assets and views
# gem 'coffee-rails', '~> 4.0.0'

# Use jquery as the JavaScript library
gem 'jquery-rails'

# Turbolinks makes following links in your web application faster. Read more: https://github.com/rails/turbolinks
# gem 'turbolinks'

# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder'

# bundle exec rake doc:rails generates the API under doc/api.
gem 'sdoc', group: :doc

# Use ActiveModel has_secure_password
# gem 'bcrypt', '~> 3.1.7'

# Use unicorn as the app server
# gem 'unicorn'

# Use Capistrano for deployment
# gem 'capistrano-rails', group: :development

# Use debugger
# gem 'debugger', group: [:development, :test]

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data'

# HAML instead of ERB
gem 'haml-rails'

# Dev only gems
group :development do
  # Better errors
  gem 'better_errors'
  gem 'binding_of_caller'

  #  Runtime optimization
  gem 'rack-mini-profiler'
  gem 'bullet'

  # Static code analysis
  gem 'rubocop', require: false
  gem 'rubycritic', require: false
  gem 'brakeman', require: false
  gem 'rails_best_practices', require: false
end

# Test only gems
group :test do
  # Profiling for MiniTest
  gem 'minitest-profile'

  # Provides code coverage analysis
  gem 'simplecov', require: false

  # For integration testing
  gem 'cucumber-rails', require: false
  gem 'selenium-webdriver'
  gem 'rspec'

  # Keeps test database consistent between tests
  gem 'database_cleaner'
end

# Authentication
gem 'devise'

# Authorization
gem 'cancancan'

# XML parser
gem 'nokogiri'

# Pagination
gem 'kaminari'
gem 'bootstrap-kaminari-views'

# Search
gem 'ransack' # , github: 'activerecord-hackery/ransack'

# Front-end validation
gem 'parsley-rails'
