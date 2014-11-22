# -*- encoding : utf-8 -*-
module RademadeAdmin
  class MenuService
    class MenuItem

      attr_accessor :model_info, :children_items

      def name
        @model_info.item_name
      end

      def model
        @model_info.model
      end

      def has_sub_items?
        sub_items.size > 0
      end

      def sub_items
        @children_items
      end

      private

      def initialize(model_info, children_items = [])
        @model_info, @children_items = model_info, children_items
      end

    end
  end
end