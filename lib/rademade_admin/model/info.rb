# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info

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
        @model_reflection.model
      end

      def item_name
        @model_configuration.item_name
      end

      def controller
        @model_configuration.controller_name
      end

      def nested?
        @model_reflection.nested?
      end

      # todo extract menu service Info::Menu
      def parent_menu_item
        @model_configuration.parent_menu_item
      end

      # Fields data class
      #
      # @return [RademadeAdmin::Model::Info::Fields]
      #
      def fields
        @model_fields ||= RademadeAdmin::Model::Info::Fields.new( _data_adapter, @model_configuration, relations )
      end

      # Relation data class
      #
      # @return [RademadeAdmin::Model::Info::Relations]
      #
      def relations
        @model_relations ||= RademadeAdmin::Model::Info::Relations.new( _data_adapter )
      end

      def uploaders
        @model_reflection.data_adapter.uploaders
      end

      def uploader_fields
        @model_reflection.data_adapter.uploader_fields
      end

      def query_adapter
        @model_reflection.query_adapter
      end

      protected

      def _data_adapter
        @model_reflection.data_adapter
      end

    end
  end
end
