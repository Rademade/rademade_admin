# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Field

        attr_reader :name, :setter, :getter, :localizable, :relation_name

        def primary?
          @primary
        end

        def date_time?
          @is_date_time
        end

        def string?
          @is_string
        end

        def boolean?
          @is_boolean
        end

        protected

        def initialize(opts = {})
          @name = opts[:name]
          @primary = opts[:primary]
          @setter = opts[:setter]
          @getter = opts[:getter]
          @is_string = opts[:is_string]
          @is_date_time = opts[:is_date_time]
          @is_boolean = opts[:is_boolean]
          @localizable = opts[:localizable]
          @relation_name = opts[:relation_name]
        end

      end
    end
  end
end