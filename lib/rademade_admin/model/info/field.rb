# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Field

        UNSAVED_FIELDS = [:id, :_id, :created_at, :deleted_at, :position]

        attr_accessor :name, :options, :type, :label

        def initialize(name, options= {})
          @name, @options = name, options
        end

        def key=(status)
          @is_key = status
        end

        def key?
          @is_key
        end

        def save?
          not UNSAVED_FIELDS.include? name
        end

        def label(field)
          @label ||= _default_label
        end

        private

        def _default_label
          name.to_s.humanize
        end

      end
    end
  end
end