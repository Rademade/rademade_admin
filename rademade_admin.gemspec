$:.push File.expand_path('../lib', __FILE__)

require 'rademade_admin/version'

Gem::Specification.new do |s|
  s.name        = 'rademade_admin'
  s.version     = RademadeAdmin::VERSION
  s.authors     = ['Vladislav Melanitskiy', 'Denis Sergienko']
  s.email       = %w(co@rademade.com olol.toor@gmail.com)
  s.homepage    = 'https://github.com/Rademade/rademade_admin'
  s.summary     = ''
  s.description = ''

  s.files = Dir['{app,config,db,lib}/**/*', 'MIT-LICENSE', 'Rakefile', 'README.rdoc']
  s.test_files = Dir['test/**/*']

  s.add_dependency 'rails', '~> 4.0'
  s.add_dependency 'kaminari'
  s.add_dependency 'carrierwave'
  s.add_dependency 'bower-rails', '~> 0.7.3'

  # Assets
  s.add_dependency 'sass'
  s.add_dependency 'compass'
  s.add_dependency 'sass-rails'
  s.add_dependency 'compass-rails'
  s.add_dependency 'coffee-rails', '~> 4.0.0'
  s.add_dependency 'uglifier', '>= 1.3.0'
  s.add_dependency 'closure-compiler'
  s.add_dependency 'yui-compressor'
  s.add_dependency 'sprockets', '~> 2.11'

  # Public JS assets
  s.add_dependency 'turbolinks'
  s.add_dependency 'magnific-popup-rails'

  # Admin
  s.add_dependency 'formtastic'
  s.add_dependency 'ckeditor'

  # Authentication
  s.add_dependency 'devise'
  s.add_dependency 'cancan'

end
