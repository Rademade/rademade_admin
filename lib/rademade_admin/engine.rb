require 'rademade_admin/routing/mapper'
require 'formtastic'

module RademadeAdmin
  class Engine < ::Rails::Engine
    isolate_namespace RademadeAdmin

    config.assets.paths << "#{config.root}/vendor/assets/javascript/bower_components"

    $LOAD_PATH << "#{config.root}/app/services/"

    paths = %W(
      #{config.root}/app/helpers/**/*.rb
      #{config.root}/app/services/**/*.rb
      #{config.root}/app/inputs/**/*.rb
      #{config.root}/lib/rademade_admin/**/*.rb
    )

    paths.each do |path|
      Dir[path].each {|f| require f }
    end

  end
end

