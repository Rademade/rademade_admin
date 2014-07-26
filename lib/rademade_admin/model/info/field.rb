# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Field

        UNSAVED_FIELDS = [:id, :_id, :created_at, :deleted_at, :position]

        attr_accessor :name, :type, :label, :as, :in_form, :in_list


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

        def label(field)
          @label ||= _default_label
        end

        protected

        def initialize(opts= {})
          @name = opts[:name]
          @primary = opts[:primary]
          @foreign_key = opts[:foreign_key]
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