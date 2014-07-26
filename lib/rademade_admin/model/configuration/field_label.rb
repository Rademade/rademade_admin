# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class FieldLabel

        attr_accessor :name, :label

        def initialize(name, label= nil)
          @name, @label = name, label
        end

      end
    end
  end
end