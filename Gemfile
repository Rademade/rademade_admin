source 'https://rubygems.org'

gemspec

gem 'rake', :require => false
gem 'tzinfo-data'

gem 'select2-rails'

# Assets
gem 'coffee-script'
gem 'sass'
gem 'sass-rails'
gem 'compass'
gem 'compass-rails'
gem 'bower-rails'
gem 'ejs'

group :development, :test do
  gem 'pry'
end

group :test do
  gem 'coveralls', :require => false

  # Mongoid
  gem 'mongoid', :github => 'mongoid/mongoid'
  gem 'mongoid-paranoia'
  gem 'mongoid_rails_migrations'
  gem 'mongoid-grid_fs'
  gem 'mongoid-tree'
  gem 'carrierwave-mongoid', :require => 'carrierwave/mongoid'

  # Active Record
  gem 'mysql2'
  gem 'globalize', '~> 4.0.2'
  gem 'activerecord_sortable'

  gem 'carrierwave'
  gem 'light_resizer', :github => 'Rademade/light_resizer'

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
