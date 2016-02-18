# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info

      attr_reader :model_reflection
      attr_writer :nested

      # Initialization for model info. Model mapper
      #
      # @param model_reflection [RademadeAdmin::Model::Reflection]
      # @param model_configuration [RademadeAdmin::Model::Configuration]
      #
      def initialize(model_reflection, model_configuration)
        @model_reflection = model_reflection
        @model_configuration = model_configuration
      end

      # Return model class
      #
      # @return [Object]
      #
      def model
        model_reflection.model
      end

      def item_name
        @model_configuration.item_name
      end

      def singular_name
        @model_configuration.singular_name
      end

      def controller
        model_reflection.controller
      end

      def module_name
        model_reflection.module_name
      end

      def hideable?
        @is_hideable ||= model_reflection.hideable?
      end

      def parent_menu
        @model_configuration.parent_menu_item
      end

      def menu_count
        @model_configuration.menu_count_block.try(:call)
      end

      # TODO it's not Model::Info logic. Move method
      def preview_url(item)
        unless @model_configuration.preview_url_block.nil?
          # calls within url helpers context
          Rails.application.routes.url_helpers.instance_exec(item, &@model_configuration.preview_url_block)
        end
      rescue
        nil
      end

      def data_items
        fields.data_items
      end

      # TODO it's not Model::Info logic. Move method
      def has_csv?
        not data_items.csv_fields.empty?
      end

      # Fields data class
      #
      # @return [RademadeAdmin::Model::Info::Fields]
      #
      def fields
        @model_fields ||= RademadeAdmin::Model::Info::Fields.new(
          _data_adapter,
          @model_configuration,
          relations,
          uploaders
        )
      end

      def query_adapter
        model_reflection.query_adapter
      end

      def persistence_adapter
        model_reflection.persistence_adapter
      end

      def label_for(name)
        @model_configuration.field_labels.label_for(name)
      end

      protected

      def _data_adapter
        model_reflection.data_adapter
      end

      # TODO add galleries component

      # @return [RademadeAdmin::Model::Info::Relations]
      def relations
        @model_relations ||= RademadeAdmin::Model::Info::Relations.new(_data_adapter)
      end

      # @return [RademadeAdmin::Model::Info::Uploaders]
      def uploaders
        @model_uploaders ||= RademadeAdmin::Model::Info::Uploaders.new(_data_adapter)
      end

    end
  end
end