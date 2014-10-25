# -*- encoding : utf-8 -*-
require 'search/part/abstract'

module RademadeAdmin
  module Search
    module Part
      class Order < Abstract

        protected

        def part_object(field, value)
          value ||= :asc
          super(field, value.to_sym)
        end

      end
    end
  end
end