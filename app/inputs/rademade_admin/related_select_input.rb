# -*- encoding : utf-8 -*-
module RademadeAdmin
  class RelatedSelectInput < SimpleForm::Inputs::CollectionSelectInput

    include ::RademadeAdmin::UriHelper

    def input
      template.content_tag(
        :div,
        RademadeAdmin::HtmlBuffer.new([select_ui_html, add_button_html]),
        html_attributes
      ) + related_list_link_html
    end

    private

    def select_ui_html
      template.text_field_tag(input_html_options_name, input_value, html_attributes)
    end

    def related_list_link_html
      if multiple?
        relation_name = RademadeAdmin::Model::Graph.instance.model_info(related_to).item_name
        template.content_tag(:a, relation_name, {
          :href => admin_related_item(model, relation_getter)
        })
      end
    end

    def input_html_options_name
      name = "#{object_name}[#{relation_getter}]"
      name += '[]' if multiple?
      name
    end

    def input_value
      #if multiple?
      #  model.send("#{relation_getter.to_s.singularize}_ids").join(',')
      #else
      #  model.send(relation_getter).id.to_s
      #end
      related_value = model.send(relation_getter)
      if multiple?
        related_value.map { |related_entity|
          related_entity.id.to_s
        }.join(',')
      else
        related_value.id.to_s
      end
    end

    def html_attributes
      {
        :class => 'select-wrapper',
        :data => reflection_data.merge('owner-class' => model.class.to_s),
        :type => 'hidden'
      }
    end

    def add_button_html
      url = new_item_url
      template.content_tag(:button, I18n.t('rademade_admin.add_new'), {
        :class => 'relation-add-button',
        'data-new' => url,
        'data-class' => related_to.to_s
      }) if url
    end

    def new_item_url
      admin_new_form_uri(related_to)
    end

    def reflection_data
      {
        'rel-multiple' => multiple?,
        'rel-class' => related_to.to_s,
        'search-url' => admin_autocomplete_uri(related_to, format: :json)
      }
    end

    def model
      @model ||= @builder.object
    end

    def related_data_item
      unless @related_data_item
        model_info = Model::Graph.instance.model_info(model.class)
        @related_data_item = model_info.data_items.data_item(attribute_name)
      end
      @related_data_item
    end

    def related_to
      related_data_item.relation.to
    end

    def relation_getter
      related_data_item.getter
    end

    def multiple?
      related_data_item.relation.many?
    end

  end
end
