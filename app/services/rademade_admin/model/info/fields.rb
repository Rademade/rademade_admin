# -*- encoding : utf-8 -*-

#rm_todo name like data_items initializer. Remove from accessors at model_info

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
        # @param uploaders [RademadeAdmin::Model::Info::Uploaders]
        #
        def initialize(data_adapter, model_configuration, relations, uploaders)
          @data_adapter = data_adapter
          @model_configuration = model_configuration
          @relations = relations
          @uploaders = uploaders
        end

        def data_items
          @data_items ||= build_items
        end

        protected

        def item_initializer
          RademadeAdmin::Model::Info::DataItem::Initializer
        end

        def build_items
          data_items = RademadeAdmin::Model::Info::DataItems.new
          used_relations = []

          # TODO extract sub - methods
          @data_adapter.fields.each do |_, field|
            relation = field.relation_name.nil? ? nil : @data_adapter.relation(field.relation_name)
            used_relations << field.relation_name if relation
            data_item = item_initializer.new(field, relation).auto
            data_items.add_data_item( data_item )
          end

          @data_adapter.relations.each do |_, relation|
            unless used_relations.include? relation.name
              data_items.add_data_item( item_initializer.new(nil, relation).from_relation )
            end
          end

          @model_configuration.all_field_names.each do |field_name|
            unless data_items.has_field?(field_name)
              data_items.add_data_item( item_initializer.new(nil, nil).build(field_name, nil) )
            end
          end

          configure_items(data_items)

          data_items
        end

        def configure_items(data_items)
          data_items.each { |item| configure_item(item) }

        end

        # @param [RademadeAdmin::Model::Info::DataItem]
        def configure_item(data_item)

          # TODO extract sub methods

          name = data_item.name

          data_item.uploader = @uploaders.uploader(name)
          data_item.order_column = nil unless @data_adapter.columns.include?(data_item.order_column)

          @model_configuration.field_labels.find(name) do |label_data|
            data_item.label = label_data.label
          end

          @model_configuration.form_fields.find_with_index(name) do |form_field_data, index|
            data_item.form_params = form_field_data.params
            data_item.in_form = true
            data_item.form_position = index
          end

          @model_configuration.list_fields.find_with_index(name) do |data, index|
            data_item.in_list = true
            data_item.list_preview_accessor = data.preview_accessor
            data_item.list_preview_handler = data.preview_handler
            data_item.list_position = index
          end

          @model_configuration.csv_fields.find_with_index(name) do |data, index|
            data_item.in_csv = true
            data_item.csv_preview_accessor = data.preview_accessor
            data_item.csv_preview_handler = data.preview_handler
            data_item.csv_position = index
          end

          data_item
        end

      end
    end
  end
end