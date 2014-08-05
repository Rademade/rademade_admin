# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Fields

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
        end

        def has_field?(name)
          @data_adapter.has_field?(name)
        end

        def list_fields
          @list_fields ||= _model_items.select{|field| field.in_list? }
        end

        def filter_fields
          []
        end

        def semantic_form_fields
          [] #todo
        end

        def origin_fields
          []
        end

        # def origin_fields
        #   @data_adapter.fields.keys + ['id']
        # end
        #

        # def default_form_fields
        #   simple_fields + @data_adapter.association_fields
        # end

        # def save_form_fields
        #   @save_form_fields ||= semantic_form_fields.keys
        # end

        # Return arrays of fields for semantic form
        #
        # @return [Array]
        #
        # def semantic_form_fields
        #   @semantic_form_fields ||= collected_form_fields
        # end

        # def filter_fields
        #   @filter_fields ||= list_fields.select do |field|
        #     field.type == String
        #   end
        # end

        # def label_for(field)
        #   @model_configuration.field_labels.label_for(field)
        # end

        # def has_field? name
        #   @data_adapter.has_field? name
        # end

        # def simple_fields
        #   @simple_fields
        # end

        # Return array of collected RademadeAdmin::Model::Info::Field
        #
        # @return [Array]
        #
        # def collected_form_fields
        #   @model_configuration.form_fields || default_form_fields
        # end

        def _model_items
          return @model_items unless @model_items.nil?

          @model_items = {}

          used_relations = []

          @data_adapter.fields.each do |name, field|

            if field.has_relation?
              used_relations << field.relation_name
              relation = @data_adapter.relation(field.relation_name)
            else
              relation = nil
            end

            model_item = RademadeAdmin::Model::Info::DataItem.new(field, relation)

            @model_configuration.field_labels.find(field.name) do |label_data|
              model_item.label = label_data.label
            end

            @model_configuration.form_fields.find(field.name) do |form_field_data|
              model_item.as = form_field_data.as
              model_item.in_form = true #todo index
            end

            @model_configuration.list_fields.find(field.name) do |list_field_data|
              model_item.in_list = true #todo index
            end

            @model_items[ model_item.name ] = model_item
          end

          @data_adapter.relations.each do |name, relation|
            pry.binding
          end

        end

      end
    end
  end
end