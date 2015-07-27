# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Input
    class RelatedSelectInput
      module RelatedList

        private

        def related_list_html
          template.content_tag(:ul, related_list_items_html, {
            :class => 'select2-items-list',
            :data => {
              :sortable => related_data_item.relation.sortable?
            }
          })
        end

        def related_list_items_html
          serialized_values = Autocomplete::BaseSerializer.new(related_value).as_json
          html = serialized_values.map do |serialized_value|
            template.content_tag(:li, related_list_item_html(serialized_value), {
              :'data-id' => serialized_value[:id],
              :class => 'select2-item'
            })
          end
          RademadeAdmin::HtmlBuffer.new(html)
        end

        def related_list_item_html(serialized_value)
          RademadeAdmin::HtmlBuffer.new([related_list_item_title_html(serialized_value), related_list_item_remove_html])
        end

        def related_list_item_title_html(serialized_value)
          template.content_tag(:button, serialized_value[:text], {
            :'data-edit' => serialized_value[:editurl],
            :class => 'select2-item-edit'
          })
        end

        def related_list_item_remove_html
          template.content_tag(:button, I18n.t('rademade_admin.relation.destroy'), {
            :'data-remove' => '',
            :class => 'select2-item-remove'
          })
        end

      end
    end
  end
end