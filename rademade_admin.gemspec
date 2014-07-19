#encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

require 'rademade_admin/version'

Gem::Specification.new do |s|
  s.name        = 'rademade_admin'
  s.version     = RademadeAdmin::VERSION
  s.authors     = ['Vladislav Melanitskiy', 'Denis Sergienko']
  s.email       = %w(co@rademade.com olol.toor@gmail.com)
  s.homepage    = 'https://github.com/Rademade/rademade_admin'
  s.summary     = 'Rails admin panel engine'
  s.description = 'Best rails admin panel. Great mechanism for customization and rapid development'
  s.licenses    = ['MIT']

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.0'
  s.add_dependency 'kaminari', '~> 0.16'
  s.add_dependency 'carrierwave', '~> 0.10'
  s.add_dependency 'bower-rails', '~> 0.7'

  # Assets
  s.add_dependency 'sprockets', '~> 2.1'
  s.add_dependency 'sprockets-sass', '~> 1.0'
  s.add_dependency 'sass-rails', '~> 4.0'
  s.add_dependency 'compass-rails', '~> 1.0'
  s.add_dependency 'coffee-rails', '~> 4.0'
  
  # Public JS assets
  s.add_dependency 'turbolinks', '~> 2.2'
  s.add_dependency 'maagnific-popup-rails', '~> 0.9', '>= 0.9.9'

  # Admin
  s.add_dependency 'formtastic', '~> 2.2'
  s.add_dependency 'ckeditor', '~> 4.0'

  # Authentication
  s.add_dependency 'devise', '~> 3.2'
  s.add_dependency 'cancan', '~> 1.6', '>= 1.6.8'

end
