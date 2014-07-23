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

    def input_value
      object_reflection = model.send(reflection_name)
      if multiple?
        object_reflection.pluck(:id).map(&:to_s).join(',')
      else
        object_reflection.try(:id).to_s
      end
    end

    def html_attributes
      {
        :class => 'select-wrapper',
        :data =>  reflection_data.merge('owner-class' => object.class.to_s),
        :type => 'hidden'
      }
    end

    def add_button_html
      url = new_item_url
      template.content_tag(:button, I18n.t('rademade_admin.add_new'), {
        :class => 'relation-add-button',
        'data-new' => url,
        'data-class' => reflection_class
      }) if url
    end

    def new_item_url
      admin_new_form_uri(reflection_class.constantize)
    end

    def reflection_data
      data = {}
      if related_with_model?
        data.merge!({
          'rel-multiple' => multiple?.to_s,
          'rel-class' => reflection_class,
          'search-url' => admin_autocomplete_uri(reflection_class, format: :json),
          'related-url' => admin_related_item(model, connected_to, method)
        })
      end
      data
    end

    def reflection_class
      related_with_model? ? reflection.class_name : nil
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

    def connected_to
      @connected_to ||= ::RademadeAdmin::LoaderService.const_get( reflection.class_name )
    end

  end
end
