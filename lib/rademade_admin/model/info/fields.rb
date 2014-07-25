# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Fields

         # todo

        attr_reader :data_adapter, :model_configuration

        # Initialize
        #
        # @param data_adapter [RademadeAdmin::Model::Adapter::Data]
        # @param model_configuration [RademadeAdmin::Model::Configuration]
        # @param relations [RademadeAdmin::Model::Info::Relations]
        #
        def initialize(data_adapter, model_configuration, relations)
          @data_adapter = data_adapter
          @model_configuration = model_configuration
          @relations = relations
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
          @filter_fields ||= list_fields.select do |field|
            field.type == String
          end
        end

        def label_for(field)
          @model_configuration.field_labels.label_for(field)
        end

        def has_field? name
          @data_adapter.has_field? name
        end

        def list
          # filter all
        end

        def form
          # filter form
        end

        def all
          # merge simple + relations
        end

        def simple_fields
          @simple_fields
        end

        # Return array of collected RademadeAdmin::Model::Info::Field
        #
        # @return [Array]
        #
        def _fields
          return @fields if @fields.is_a? Array
          @fields = []
          @data_adapter.fields.each do |name, data_field|
            field = ::RademadeAdmin::Model::Info::Field.new(name.to_sym)
            field.type = data_field.type

            # Load label
            # todo
            @model_configuration.field_labels.find(field.name) do |label|
              field.label = label
            end

            @model_configuration.form_fields.


            # field.label
            #todo add label and :as from configuration
            field.key = @data_adapter.foreign_key?(field)
            @fields << field
          end
        end

        def _relations_fields
          @relations_fields = relations.all.map.field do |relation|

          end
        end

        def collected_form_fields
          @model_configuration.form_fields || default_form_fields
        end

      end
    end
  end
end