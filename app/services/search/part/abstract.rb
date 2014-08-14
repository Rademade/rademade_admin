module RademadeAdmin
  module Search
    module Part
      class Abstract

        attr_reader :parts

        def initialize
          @parts = []
        end

        def add(field, value)
          @parts << {
            :field => field,
            :value => value
          }
        end

        def sub_add(part)
          @parts << part
        end

      end
    end
  end
end