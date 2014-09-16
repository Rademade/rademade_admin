# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class DataItems
        include ::Enumerable
        # rm_todo extract mixins

        UNINFORMATIVE_FIELDS = [:_id, :deleted_at, :position]

        def initialize
          @data_items = {}
        end

        def items
          @data_items
        end

        def each(&block)
          items.each(&block)
        end

        # @param data_item [RademadeAdmin::Model::Info::DataItem]
        def add_data_item(data_item)
          items[data_item.name] = data_item
        end

        def data_item(name)
          items[name.to_sym]
        end

        def has_field?(name)
          items.select{ |_, data_item| data_item.has_name? name }.length > 0
        end

        def primary_field
          @primary_field ||= find_primary_field
        end

        def origin_fields
          @origin_fields ||= collect_field_names { |data_item| data_item.simple_field? }
        end

        def related_fields
          @related_fields ||= items.select { |_, data_item| data_item.has_relation? }
        end

        def uploader_fields
          @uploader_fields ||= items.select { |_, data_item| data_item.has_uploader? }
        end

        def localizable_fields
          @localizable_fields ||= items.select { |_, data_item| data_item.localizable? }
        end

        def list_fields
          @list_fields ||= collect_list_fields
        end

        def filter_fields
          @autocomplete_fields ||= collect_field_names { |data_item| data_item.string_field? }
        end

        def form_fields
          @form_fields ||= collect_form_fields
        end

        def form_fields_without_locale
          @form_fields_without_locale ||= collect_localized_form_fields(false)
        end

        def form_fields_with_locale
          @form_fields_with_locale ||= collect_localized_form_fields(true)
        end

        # Get Array of RademadeAdmin::Model::Info::DataItem for saving
        #
        # @return [Array]
        #
        def save_form_fields
          @save_form_fields ||= collect_save_form_fields
        end

        private

        def find_primary_field
          items.each do |_, data_item|
            return data_item if data_item.primary_field?
          end
          nil
        end

        def collect_list_fields
          fields = items.select { |_, data_item| data_item.in_list? }
          fields.empty? ? _default_fields.values : fields.values.sort_by(&:list_position)
        end

        def collect_form_fields
          fields = items.select { |_, data_item| data_item.in_form? }
          fields.empty? ? _default_fields : fields
        end

        def collect_localized_form_fields(localizable)
          form_fields.select { |_, data_item|
            data_item.localizable?(localizable)
          }.values.sort_by(&:form_position)
        end

        def collect_save_form_fields
          fields = form_fields.select { |_, data_item| data_item.simple_field? }
          fields = items.select { |_, data_item| data_item.simple_field? } if fields.empty?
          fields.values.map(&:getter)
        end

        def _default_fields
          items.reject { |_, data_item| UNINFORMATIVE_FIELDS.include? data_item.name } # todo remove sortable fields
        end

        def collect_field_names
          field_names = []
          items.each do |_, data_item|
            field_names << data_item.name if yield(data_item)
          end
          field_names
        end

      end
    end
  end
end