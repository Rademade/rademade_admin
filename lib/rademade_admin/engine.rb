# -*- encoding : utf-8 -*-
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

    config.autoload_paths += Dir["#{config.root}/lib/**/"]
    config.autoload_paths += Dir["#{config.root}/app/services/**/"]
    config.autoload_paths += Dir["#{config.root}/app/helpers/**/"]
    config.autoload_paths += Dir["#{config.root}/app/inputs/**/"]

  end
end
