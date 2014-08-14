# -*- encoding : utf-8 -*-
require 'search/part/abstract'

module RademadeAdmin
  module Search
    module Part
      class Where < Abstract

        attr_reader :type

        def initialize(type)
          super()
          @type = type
        end

      end
    end
  end
end
