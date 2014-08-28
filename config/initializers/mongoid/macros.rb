# encoding: utf-8
module Mongoid
  module Relations
    module Macros
      module ClassMethods

        alias_method :original_reference, :reference

        private

        def reference(metadata, type = Object)
          original_reference(metadata, type)
          if metadata.sortable?
            to_class = RademadeAdmin::LoaderService.const_get(metadata.class_name)
            to_class.field metadata.sortable_field, :type => Integer
            to_class.scope metadata.sortable_scope, -> { all.prepend_order_by(metadata.sortable_field => :asc) }
          end
        end

      end
    end
  end
end