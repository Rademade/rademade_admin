source 'https://rubygems.org'

gemspec

# Assets
gem 'sass-rails'

# Utility gems used in both development & test environments
gem 'rake', require: false

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'coveralls', :require => false
  # Mongoid
  gem 'mongoid'
  gem 'mongoid-paranoia'
  gem 'mongoid_rails_migrations'
  gem 'mongoid-grid_fs'
  gem 'mongoid-tree'
  gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'
  # AR
  gem 'mysql2'

  gem 'light_resizer', :github => 'Rademade/light_resizer'
  gem 'rspec', '>= 3'
  gem 'spork-rails'
  gem 'rspec-rails', '3.0.0'
  gem 'capybara'
  gem 'database_cleaner'
  gem 'capybara-webkit'
  gem 'capybara-screenshot'
  gem 'factory_girl_rails', :require => false
  gem 'simplecov'
end
