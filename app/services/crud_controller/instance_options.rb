module RademadeAdmin
  module CrudController
    module InstanceOptions

      attr_reader :model_class, :model_reflection, :model_name, :item_name,
                  :origin_fields, :list_fields, :save_form_fields, :semantic_form_fields

      def load_model_options
        @model_name = self.class.model_name
        @model_class = self.class.model_class
        @model_reflection = self.class.model_reflection
        @item_name = self.class.item_name
      end

      def load_field_options
        @list_fields = self.class.list_fields
        @origin_fields = self.class.origin_fields
        @save_form_fields = self.class.save_form_fields
        @semantic_form_fields = self.class.semantic_form_fields
      end

      def load_template_options
        @form_template_path ||= form_template_path
      end

      def load_options
        load_model_options
        load_field_options
        load_template_options
      end
    end
  end
end