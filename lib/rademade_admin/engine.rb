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
      filter_ckeditor_assets = Proc.new do |logical_path|
        File.fnmatch('ckeditor/*', logical_path) \
          && ! [
            'ckeditor/CHANGES',
            'ckeditor/LICENSE',
            'ckeditor/README',
            'ckeditor/plugins/scayt/CHANGELOG',
            'ckeditor/plugins/scayt/LICENSE',
            'ckeditor/plugins/scayt/README',
            'ckeditor/plugins/wsc/LICENSE',
            'ckeditor/plugins/wsc/README',
            'ckeditor/skins/moono/readme',
          ].include?(logical_path)
      end
      app.config.assets.precompile << filter_ckeditor_assets
      app.config.assets.precompile += %w(rademade_admin.css rademade_admin.js rademade_admin/fav1.ico)
    end

    $LOAD_PATH << "#{config.root}/app/services/"

    paths = %W(
      #{config.root}/app/helpers/**/*.rb
      #{config.root}/app/services/**/*.rb
      #{config.root}/app/inputs/**/*.rb
      #{config.root}/lib/rademade_admin/**/*.rb
    )

    paths.each do |path|
      Dir[path].each { |f| require f  }
    end

    config.action_controller.default_url_options = RademadeAdmin::Engine.routes.default_url_options

  end
end
