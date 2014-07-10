module RademadeAdmin
  module Model
    class Configuration

      attr_accessor :model_name, :model_class, :item_name, :parent_menu_item, :list_fields, :form_fields

      private

      def model(model)
        self.model_name = model
      end

      def item(item)
        self.item_name = item
      end

      def parent_menu(parent_menu)
        self.parent_menu_item = parent_menu
      end

      def list(*field_options, &block)
        self.list_fields = fields(*field_options, &block)
      end

      def form(*field_options, &block)
        self.form_fields = fields(*field_options, &block)
      end

      def fields(*field_options, &block)
        model_fields = block_given? ? Fields.init_from_block(&block) : Fields.init_from_options(field_options)
        model_fields.fields
      end

    end
  end
end