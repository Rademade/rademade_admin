module RademadeAdmin
  module Search
    module Conditions
      class Where

        attr_reader :type, :parts

        def initialize(type)
          @type = type
          @parts = []
        end

        def add(field, value)
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