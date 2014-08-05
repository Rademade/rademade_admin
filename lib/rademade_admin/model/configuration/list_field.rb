# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class ListField

        attr_accessor :name, :options

        def initialize(name)
          @name = name
        end

      end
    end
  end
end