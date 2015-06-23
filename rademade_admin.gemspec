#encoding: utf-8
$:.push File.expand_path('../lib', __FILE__)

require 'rademade_admin/version'

Gem::Specification.new do |s|
  s.name        = 'rademade_admin'
  s.version     = RademadeAdmin::VERSION
  s.authors     = ['Vladislav Melanitskiy', 'Denis Sergienko', 'Sergey Kuzhavskiy']
  s.email       = %w(co@rademade.com olol.toor@gmail.com kuzh@rademade.com)
  s.homepage    = 'https://github.com/Rademade/rademade_admin'
  s.summary     = 'Rails admin panel engine'
  s.description = 'Best rails admin panel. Great mechanism for customization and rapid development'
  s.licenses    = ['MIT']

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  # Core dependencies
  s.add_dependency 'rails', '>= 4.0'
  s.add_dependency 'kaminari', '~> 0.16'
  s.add_dependency 'carrierwave', '~> 0.10'

  # Assets
  s.add_dependency 'bower-rails', '~> 0.8', '>= 0.8.2'
  s.add_dependency 'sprockets-sass', '~> 1.0'
  s.add_dependency 'sass-rails', '>= 4.0'
  s.add_dependency 'compass-rails', '~> 1.0'
  s.add_dependency 'coffee-rails', '~> 4.0'
  s.add_dependency 'select2-rails', '>= 3.5.0'

  s.add_dependency 'i18n-js'
  s.add_dependency 'ejs'
  
  # Public JS assets
  s.add_dependency 'turbolinks', '~> 2.2'

  # Admin
  s.add_dependency 'slim'
  s.add_dependency 'cells', '>= 3.5.1', '< 4.0.0'
  s.add_dependency 'simple_form'
  s.add_dependency 'ckeditor', '~> 4.0'
  s.add_dependency 'cancan', '~> 1.6', '>= 1.6.8'
  s.add_dependency 'breadcrumbs'
  s.add_dependency 'mongoid_sortable_relation' # todo move to rademade_admin_mongoid module

end
