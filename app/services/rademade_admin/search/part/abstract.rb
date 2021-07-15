module RademadeAdmin
  module Search
    module Part
      class Abstract

        attr_reader :parts

        def initialize
          @parts = []
        end

        def add(field, value)
          @parts << part_object(field, value)
        end

        def unshift(field, value)
          @parts.unshift(part_object(field, value))
        end

        def sub_add(part)
          @parts << part
        end

        def sub_unshift(part)
          @parts.unshift part
        end

        protected

        def part_object(field, value)
          {
            :field => field,
            :value => value
          }
        end

      end
    end
  end
end