# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration

      attr_reader :controller_name, :parent_menu_item

      def initialize(controller_name)
        @controller_name = controller_name
      end

      def model_name
        @model_name ||= @controller_name.classify
      end

      def item_name
        @item_name ||= model_name.underscore.gsub('/', '_').humanize.pluralize
      end

      def model_class
        @model_class ||= RademadeAdmin::LoaderService.const_get(model_name)
      end

      # Return configured list info
      #
      # @return [RademadeAdmin::Model::Configuration::ListFields]
      #
      def list_fields
        @list_fields ||= RademadeAdmin::Model::Configuration::ListFields.new
      end

      # Return configured fields info
      #
      # @return [RademadeAdmin::Model::Configuration::FormFields]
      #
      def form_fields
        @form_fields ||= RademadeAdmin::Model::Configuration::FormFields.new
      end

      # Return configured fields info
      #
      # @return [RademadeAdmin::Model::Configuration::FieldsLabels]
      #
      def field_labels
        @field_labels ||= RademadeAdmin::Model::Configuration::FieldsLabels.new
      end

      private

      def model(model_name)
        @model_name = model_name
      end

      def name(item_name)
        @item_name = item_name
      end

      def parent_menu(parent_menu_item)
        @parent_menu_item = parent_menu_item
      end

      def labels(*field_options, &block)
        field_labels.configure(*field_options, &block)
      end

      def list(*field_options, &block)
        list_fields.configure(*field_options, &block)
      end

      def form(*field_options, &block)
        form_fields.configure(*field_options, &block)
      end

    end
  end
end
