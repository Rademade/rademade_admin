# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Search
    module Part
      class Where

        attr_reader :type, :parts

        def initialize(type)
          @type = type
          @parts = []
        end

        def add(field, value)
          #todo add =, <=, >=, !=
          @parts << {
            :field => field,
            :value => value
          }
        end

        def sub_add(where)
          @parts << where
        end

      end
    end
  end
end
