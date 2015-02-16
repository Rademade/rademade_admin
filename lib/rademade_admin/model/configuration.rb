# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration

      attr_reader :controller, :parent_menu_item, :model_name, :menu_count_block, :preview_url_block

      def initialize(controller)
        @controller = controller
      end

      def item_name
        @item_name ||= singular_name.pluralize
      end

      def singular_name
        @singular_name ||= model_name.underscore.gsub('/', '_').humanize
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

      def all_field_names
        @all_field_names ||= Set.new(list_fields.all.map(&:name) + form_fields.all.map(&:name))
      end

      def model(model_name)
        @model_name = model_name.to_s
      end

      def menu_count(&block)
        @menu_count_block = block
      end

      def preview_url(&block)
        @preview_url_block = block
      end

      private

      def name(item_name)
        @item_name = item_name
      end

      def parent_menu(parent_model)
        @parent_menu_item = parent_model.is_a?(String) ? RademadeAdmin::LoaderService.const_get(parent_model) : parent_model
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
