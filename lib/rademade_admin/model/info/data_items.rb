# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class DataItems

        def initialize
          @data_items = {}
        end

        # @param data_item [RademadeAdmin::Model::Info::DataItem]
        def add_data_item(data_item)
          @data_items[data_item.name] = data_item
        end

        def data_item(name)
          @data_items[name.to_sym]
        end

        def has_field?(name)
          not @data_items[name.to_sym].nil?
        end

        def primary_field
          @primary_field ||= find_primary_field
        end

        def origin_fields
          @origin_fields ||= collect_field_names { |data_item| data_item.simple_field? }
        end

        def related_fields
          @related_fields ||= @data_items.select { |_, data_item| data_item.has_relation? }
        end

        def uploader_fields
          @uploader_fields ||= @data_items.select { |_, data_item| data_item.has_uploader? }
        end

        def list_fields
          @list_fields ||= collect_list_fields
        end

        def filter_fields
          @autocomplete_fields ||= collect_field_names { |data_item| data_item.string_field? }
        end

        def semantic_form_fields
          @form_fields ||= collect_form_fields
        end

        def save_form_fields
          @save_form_fields ||= collect_field_names { |data_item| data_item.in_form? and not data_item.has_relation? }
        end

        private

        def find_primary_field
          @data_items.each do |_, data_item|
            return data_item if data_item.primary_field?
          end
          nil
        end

        def collect_list_fields
          fields = @data_items.select { |_, data_item| data_item.in_list? }
          if fields.empty?
            fields = @data_items
          else
            fields = fields.values.sort_by(&:list_position)
          end
          fields
        end

        def collect_form_fields
          fields = @data_items.select { |_, data_item| data_item.in_form? }
          if fields.empty?
            fields = @data_items
          else
            fields = fields.values.sort_by(&:form_position)
          end
          fields
        end

        def collect_field_names
          field_names = []
          @data_items.each do |_, data_item|
            field_names << data_item.name if yield(data_item)
          end
          field_names
        end

      end
    end
  end
end