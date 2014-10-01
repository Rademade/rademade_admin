# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Field

        UNSAVED_FIELDS = [:id, :_id, :created_at, :deleted_at, :position]

        attr_reader :name, :setter, :getter, :type, :is_date_time, :localizable, :relation_name

        def key=(status)
          @is_key = status
        end

        def primary?
          @primary
        end

        def save?
          not UNSAVED_FIELDS.include? name
        end

        protected

        def initialize(opts = {})
          @name = opts[:name]
          @primary = opts[:primary]
          @setter = opts[:setter]
          @getter = opts[:getter]
          @type = opts[:type]
          @is_date_time = opts[:is_date_time]
          @localizable = opts[:localizable]
          @relation_name = opts[:relation_name]
        end

      end
    end
  end
end