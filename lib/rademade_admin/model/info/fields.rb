# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Fields

        UNSAVED_FIELDS = [:id, :_id, :created_at, :deleted_at, :position] # todo

        attr_reader :data_adapter, :model_configuration

        # Initialize
        #
        # @param data_adapter [RademadeAdmin::Model::Adapter::Data]
        # @param model_configuration [RademadeAdmin::Model::Configuration]
        #
        def initialize(data_adapter, model_configuration)
          @data_adapter = data_adapter
          @model_configuration = model_configuration
          @initialized = false
        end

        def origin_fields
          @data_adapter.fields.keys + ['id']
        end

        def list_fields
          @list_fields ||= (@model_configuration.list_fields || simple_fields)
        end

        def default_form_fields
          simple_fields + @data_adapter.association_fields
        end

        def save_form_fields
          @save_form_fields ||= semantic_form_fields.keys
        end

        # Return arrays of fields for semantic form
        #
        # @return [Array]
        #
        def semantic_form_fields
          @semantic_form_fields ||= collected_form_fields
        end

        def filter_fields
          @filter_fields ||= load_filter_fields
        end

        def label_for(field)
          @model_configuration.field_labels.label_for(field)
        end

        def has_field? name
          @data_adapter.has_field? name
        end

        private

        def simple_fields
          init_model_fields
          @simple_fields
        end

        # todo need refactor
        def init_model_fields
          unless @initialized
            @fields_data = {}
            @simple_fields = []
            @data_adapter.fields.each do |name, field|
              field_name = name.to_sym
              @fields_data[field_name] = field
              #!a && !b => !(a || b)
              unless UNSAVED_FIELDS.include?(field_name) || @data_adapter.foreign_key?(field)
                @simple_fields << field_name
              end
            end
            @initialized = true
          end
        end

        def load_filter_fields
          init_model_fields
          list_fields.select do |field|
            @fields_data.has_key?(field) and @fields_data[field].type == String
          end
        end

        def collected_form_fields
          @model_configuration.form_fields || default_form_fields
        end

      end
    end
  end
end