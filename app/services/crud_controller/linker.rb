module RademadeAdmin
  module CrudController
    module Linker

      def link(item)
        if has_one_relation?
          set_attribute(item, params[:parent_id])
        else
          old_data = get_attribute(item)
          old_data << params[:parent_id]
          set_attribute(item, old_data)
        end

      end

      def unlink(item)
        if has_one_relation?
          set_attribute(item, nil)
        else
          old_data = get_attribute(item)
          new_data = old_data - Array(params[:parent_id])
          set_attribute(item, new_data)
        end

      end

      private

      def has_one_relation?
        model_info.has_one.include? params[:parent]
      end

      def relation_suffix
        has_one_relation? ? '_id' : '_ids'
      end

      def get_attribute(item)
        item.send(relation_field)
      end

      def relation_field
        params[:parent].downcase + relation_suffix
      end

      def set_attribute(item, new_value)
        item.send(relation_field + '=', new_value)
      end

    end
  end
end