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
        def initialize(data_adapter, model_configuration, relations, uploaders)
          @data_adapter = data_adapter
          @model_configuration = model_configuration
          @relations = relations
          @uploaders = uploaders
        end

        def has_field?(name)
          @data_adapter.has_field?(name)
        end

        def primary_field
          @primary_field ||= find_primary_field
        end

        def list_fields
          @list_fields ||= collect_list_fields
        end

        def semantic_form_fields
          @form_fields ||= collect_form_fields
        end

        def uploader_fields
          @uploader_fields ||= _model_items.select { |model_item| model_item.uploader? }
        end

        def save_form_fields
          @save_form_fields ||= _model_items.select { |model_item|
            model_item.in_form? and not model_item.has_relation?
          }.map(&:name)
        end

        def filter_fields
          @autocomplete_fields ||= _model_items.select { |model_item| model_item.field.type == String }.map(&:name)
        end

        def origin_fields
          _model_items.select { |model_item| not(model_item.uploader? or model_item.has_relation?) }.map(&:name)
        end

        private

        def _model_items
          return @model_items unless @model_items.nil?

          @model_items = []

          used_relations = []

          @data_adapter.fields.each do |_, field|
            if field.has_relation?
              used_relations << field.relation_name
              relation = @data_adapter.relation(field.relation_name)
            else
              relation = nil
            end
            _add_data_item(field, relation)
          end

          @data_adapter.relations.each do |_, relation|
            unless used_relations.include? relation.name
              _add_data_item(nil, relation)
            end
          end

          @model_items

        end

        def _add_data_item(field, relation)
          name = field.nil? ? relation.name : field.name

          model_item = RademadeAdmin::Model::Info::DataItem.new(name, field, relation)
          model_item.is_uploader = @uploaders.has_key? name

          @model_configuration.field_labels.find(name) do |label_data|
            model_item.label = label_data.label
          end

          @model_configuration.form_fields.find_with_index(name) do |form_field_data, index|
            model_item.form_params = form_field_data.params
            model_item.in_form = true
            model_item.form_position = index
          end

          @model_configuration.list_fields.find_with_index(name) do |_, index|
            model_item.in_list = true
            model_item.list_position = index
          end

          @model_items << model_item
        end

        def find_primary_field
          _model_items.each do |model_item|
            return model_item if model_item.field.primary?
          end
          nil
        end

        def collect_list_fields
          fields = _model_items.select { |model_item| model_item.in_list? }
          if fields.empty?
            fields = _model_items
          else
            fields = fields.sort_by(&:list_position)
          end
          fields
        end

        def collect_form_fields
          fields = _model_items.select { |model_item| model_item.in_form? }
          if fields.empty?
            fields = _model_items
          else
            fields = fields.sort_by(&:form_position)
          end
          fields
        end

      end
    end
  end
end