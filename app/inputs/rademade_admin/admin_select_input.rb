# -*- encoding : utf-8 -*-
module RademadeAdmin
  class AdminSelectInput < Formtastic::Inputs::SelectInput

    include ::RademadeAdmin::UriHelper

    alias_method :parent_select_html, :select_html

    def select_html
      template.content_tag(
        :div,
        RademadeAdmin::HtmlBuffer.new([select_ui_html, add_new_button_html]),
        html_attributes
      )
    end

    private

    def add_new_button_html
      related_with_model? ? add_button_html : ''
    end

    def select_ui_html
      template.text_field_tag(extra_input_html_options[:name], input_value, html_attributes)
    end

    def input_html_options_name
      "#{object_name}[#{relation.id_getter}]"
    end

    def input_value
      related_value = model.send(relation.id_getter)
      if relation.many?
        related_value.map(&:to_s).join(',')
      else
        related_value.to_s
      end
    end

    def html_attributes
      {
        :class => 'select-wrapper',
        :data => reflection_data.merge('owner-class' => object.class.to_s),
        :type => 'hidden'
      }
    end

    def add_button_html
      url = new_item_url
      template.content_tag(:button, I18n.t('rademade_admin.add_new'), {
        :class => 'relation-add-button',
        'data-new' => url,
        'data-class' => relation.to.to_s
      }) if url
    end

    def new_item_url
      admin_new_form_uri(relation.to)
    end

    def reflection_data
      if related_with_model?
        {
          'rel-multiple' => relation.many?,
          'rel-class' => relation.to.to_s,
          'search-url' => admin_autocomplete_uri(relation.to, format: :json)
        }
      else
        {}
      end
    end

    def related_with_model?
      !association.nil?
    end

    def reflection_name
      reflection.is_a?(Hash) ? reflection[:name] : reflection.name
    end

    def model
      @model ||= builder.object
    end

    private

    def relation
      @relation ||= Model::Graph.instance.model_info(model.class).relations.relation(reflection_name)
    end

  end
end
