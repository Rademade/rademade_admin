# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Field

        UNSAVED_FIELDS = [:id, :_id, :created_at, :deleted_at, :position]

        attr_accessor :name, :setter, :getter, :type, :label, :as, :in_form, :in_list

        alias_method :in_list?, :in_list
        alias_method :in_form?, :in_form

        def key=(status)
          @is_key = status
        end

        def primary?
          @primary
        end

        def foreign_key?
          @foreign_key
        end

        def save?
          not UNSAVED_FIELDS.include? name
        end

        def label
          @label ||= _default_label
        end

        protected

        def initialize(opts= {})
          @name = opts[:name]
          @primary = opts[:primary]
          @foreign_key = opts[:foreign_key]
          @setter = opts[:setter]
          @getter = opts[:getter]
          @type = opts[:type]
        end

        private

        def _default_label
          name.to_s.humanize
        end

      end
    end
  end
end