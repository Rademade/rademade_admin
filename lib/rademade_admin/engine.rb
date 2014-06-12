require 'pry'
module RademadeAdmin
  class Engine < ::Rails::Engine
    isolate_namespace RademadeAdmin

    paths = %W(
      #{config.root}/app/helpers/**/*.rb
      #{config.root}/app/services/**/*.rb
      #{config.root}/app/inputs/**/*.rb
      #{config.root}/lib/rademade_admin/**/*.rb
    )

    paths.each do |path|

      Dir[path].each do |f|
        require f
        p f
      end
    end

  end
end
