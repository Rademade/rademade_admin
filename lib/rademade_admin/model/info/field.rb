# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Field

        attr_reader :name, :setter, :getter, :localizable, :relation_name

        def primary?
          @primary
        end

        def string?
          @type == Type::STRING
        end

        def boolean?
          @type == Type::BOOLEAN
        end

        def date?
          @type == Type::DATE
        end

        def date_time?
          @type == Type::DATE_TIME
        end

        protected

        def initialize(opts = {})
          @name = opts[:name]
          @primary = opts[:primary]
          @setter = opts[:setter]
          @getter = opts[:getter]
          @type = opts[:type]
          @localizable = opts[:localizable]
          @relation_name = opts[:relation_name]
        end

      end
    end
  end
end