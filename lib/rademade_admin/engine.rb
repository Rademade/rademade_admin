# -*- encoding : utf-8 -*-
require 'rademade_admin/routing/mapper'
require 'simple_form'
require 'select2-rails'
require 'carrierwave'
require 'light_resizer'

module RademadeAdmin
  class Engine < ::Rails::Engine
    isolate_namespace RademadeAdmin

    config.assets.paths << "#{config.root}/vendor/assets/javascript/bower_components"

    initializer 'ckeditor.assets_precompile', :group => :all do |app|
      app.config.assets.precompile += %w(rademade_admin.css rademade_admin.js ckeditor/* rademade_admin/fav1.ico)
    end

    $LOAD_PATH << "#{config.root}/app/services/"

    config.to_prepare do
      Dir.glob(Rails.root + 'app/decorators/**/*_decorator*.rb').each do |c|
        require_dependency(c)
      end
    end
    paths = %W(
      #{config.root}/app/helpers/**/*.rb
      #{config.root}/app/services/**/*.rb
      #{config.root}/app/inputs/**/*.rb
      #{config.root}/lib/rademade_admin/**/*.rb
    )

    paths.each do |path|
      Dir[path].each { |f| require f  }
    end

  end
end