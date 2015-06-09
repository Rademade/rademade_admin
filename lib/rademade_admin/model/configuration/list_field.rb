# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class ListField

        attr_accessor :name

        def initialize(name, opts = {})
          @name = name
          @opts = opts
        end

        def preview_accessor
          @opts[:method]
        end

        def preview_handle
          @opts[:handle]
        end

      end
    end
  end
end