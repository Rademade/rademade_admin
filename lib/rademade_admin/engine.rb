require 'rademade_admin/routing/mapper'
require 'formtastic'

module RademadeAdmin
  class Engine < ::Rails::Engine
    isolate_namespace RademadeAdmin

    paths = %W(
      #{config.root}/app/helpers/**/*.rb
      #{config.root}/app/services/crud_controller/*.rb
      #{config.root}/app/services/**/*.rb
      #{config.root}/app/inputs/**/*.rb
      #{config.root}/lib/rademade_admin/**/*.rb
    )

    paths.each do |path|
      Dir[path].each {|f| require f }
    end

  end
end

