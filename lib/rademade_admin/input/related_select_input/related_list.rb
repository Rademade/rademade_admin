# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Input
    class RelatedSelectInput
      module RelatedList

        protected

        def related_list_html
          template.content_tag(:ul, related_list_items_html, {
            :class => 'select2-items-list',
            :data => {
              :sortable => sortable_relation?
            }
          })
        end

        def related_list_items_html
          serialized_values = serializer.new(related_value).as_json
          html = serialized_values.map do |serialized_value|
            template.content_tag(:li, related_list_item_html(serialized_value), {
              :class => related_item_class,
              :data => {
                :id => serialized_value[:id]
              }
            })
          end
          RademadeAdmin::HtmlBuffer.new(html)
        end

        def related_list_item_html(serialized_value)
          RademadeAdmin::HtmlBuffer.new([
            draggable_button_html,
            related_list_item_title_html(serialized_value),
            related_list_item_remove_html
          ])
        end

        def draggable_button_html
          template.content_tag(:i, '', {
            :class => 'draggable-btn'
          }) if sortable_relation?
        end

        def related_list_item_title_html(serialized_value)
          template.content_tag(:button, serialized_value[:text], {
            :class => 'select2-item-edit',
            :data => {
              :edit => serialized_value[:editurl]
            }
          })
        end

        def related_list_item_remove_html
          template.content_tag(:button, I18n.t('rademade_admin.relation.destroy'), {
            :class => 'select2-item-remove',
            :data => {
              :remove => ''
            }
          })
        end

        def related_item_class
          class_name = 'select2-item'
          class_name += ' is-draggable' if sortable_relation?
          class_name
        end

        def sortable_relation?
          related_data_item.relation.sortable?
        end

      end
    end
  end
end