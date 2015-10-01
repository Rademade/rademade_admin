source 'https://rubygems.org'

# Load gemspec
gemspec

# Development gems
group :development, :test do
  gem 'pry'
end

group :test do
  gem 'coveralls', :require => false

  # Mongoid
  gem 'mongoid'
  gem 'mongoid-paranoia'
  gem 'mongoid_rails_migrations', '1.0.0'
  gem 'mongoid-grid_fs'
  gem 'mongoid-tree'
  gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

  # Active Record
  gem 'mysql2', '~> 0.3', '< 0.4'
  gem 'globalize'
  gem 'activerecord_sortable'

  # Uploaders
  gem 'carrierwave'

  # Testing utilities
  gem 'rspec', '~> 3.0'
  gem 'spork-rails'
  gem 'rspec-rails', '~> 3.0'
  gem 'capybara'
  gem 'capybara-screenshot'
  gem 'database_cleaner'
  gem 'capybara-webkit'
  gem 'factory_girl_rails', :require => false
  gem 'simplecov'
end
