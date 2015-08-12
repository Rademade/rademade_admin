# -*- encoding : utf-8 -*-
require 'rademade_admin/input/related_select_input/model_data'
require 'rademade_admin/input/related_select_input/related_list'

module RademadeAdmin
  class RelatedSelectInput < SimpleForm::Inputs::CollectionSelectInput

    include ::RademadeAdmin::UriHelper
    include ::RademadeAdmin::Input::RelatedSelectInput::ModelData
    include ::RademadeAdmin::Input::RelatedSelectInput::RelatedList

    def input(wrapper_options = {})
      template.content_tag(
        :div,
        RademadeAdmin::HtmlBuffer.new([select_ui_html, add_button_html]),
        html_attributes
      ) + related_html
    end

    protected

    def select_ui_html
      template.text_field_tag(input_html_options_name, '', html_attributes)
    end

    def related_html
      if multiple?
        related_list_html
      else
        RademadeAdmin::HtmlBuffer.new([related_item_html, edit_button_html])
      end
    end

    def input_html_options_name
      name = "#{object_name}[#{relation_getter}]"
      name += '[]' if multiple?
      name
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
      search_url = admin_autocomplete_uri(related_to, :format => :json)
      data = {
        :'rel-multiple' => multiple?,
        :'rel-class' => related_to.to_s
      }
      data[:'search-url'] = search_url unless search_url.nil?
      data
    end

    def related_item_html
      if related_value.nil?
        nil
      else
        serialized_data = serializer.new([related_value]).as_json.first
        template.content_tag(:input, '', {
          :type => 'hidden',
          :data => serialized_data
        })
      end
    end

    def edit_button_html
      template.content_tag(:button, I18n.t('rademade_admin.edit_related_item'), {
        :class => 'btn blue-btn',
        :'data-edit-relation' => true
      })
    end

    def serializer
      Autocomplete::BaseSerializer
    end

  end
end