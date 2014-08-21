# encoding: utf-8
module Mongoid
  module Relations
    class Metadata

      def sortable
        self[:sortable]
      end

      def sortable?
        !!sortable
      end

      def sortable_field
        :"#{prefix_name}_position"
      end

      def sortable_scope
        :"sort_for_#{prefix_name}"
      end

      private

      # rm_todo rename
      def prefix_name
        @prefix ||= polymorphic? ? as : inverse_class_name.underscore.gsub('/', '_')
      end

    end
  end
end