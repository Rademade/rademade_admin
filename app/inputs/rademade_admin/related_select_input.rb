# -*- encoding : utf-8 -*-
require 'rademade_admin/input/related_select_input/model_data'
require 'rademade_admin/input/related_select_input/related_list'

module RademadeAdmin
  class RelatedSelectInput < SimpleForm::Inputs::CollectionSelectInput

    include ::RademadeAdmin::UriHelper
    include ::RademadeAdmin::Input::RelatedSelectInput::ModelData
    include ::RademadeAdmin::Input::RelatedSelectInput::RelatedList

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

    def input_html_options_name
      name = "#{object_name}[#{relation_getter}]"
      name += '[]' if multiple?
      name
    end

    def input_value
      if multiple?
        ''
      else
        related_value.nil? ? nil : related_value.id.to_s
      end
    end

    def html_attributes
      {
        :class => 'select-wrapper',
        :data => reflection_data.merge(:'owner-class' => model.class.to_s),
        :type => 'hidden'
      }
    end

    def add_button_html
      url = admin_new_form_uri(related_to)
      template.content_tag(:button, I18n.t('rademade_admin.add_new'), {
        :class => 'btn green-btn relation-add-button r-margin fl-l',
        :'data-new' => url,
        :'data-class' => related_to.to_s
      }) if url
    end

    def reflection_data
      {
        :'rel-multiple' => multiple?,
        :'rel-class' => related_to.to_s,
        :'search-url' => admin_autocomplete_uri(related_to, :format => :json)
      }
    end

  end
end
