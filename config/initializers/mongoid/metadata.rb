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
        :"#{prefix}_position"
      end

      def sortable_scope
        :"sort_for_#{prefix}"
      end

      private

      # rm_todo rename
      def prefix
        @prefix ||= prefix_name
      end

      def prefix_name
        if polymorphic?
          as
        else
          inverse_of || inverse_class_name.underscore.gsub('/', '_')
        end
      end

    end
  end
end