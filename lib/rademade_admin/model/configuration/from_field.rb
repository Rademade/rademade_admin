# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class FormField

        attr_accessor :name, :as

        def initialize(name, as = '')
          @name, @as = name, as
        end

      end
    end
  end
end