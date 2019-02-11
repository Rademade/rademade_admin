# -*- encoding : utf-8 -*-
module RademadeAdmin
  class RelatedSelectInput < SimpleForm::Inputs::CollectionSelectInput

    include ::RademadeAdmin::UriHelper
    include ::RademadeAdmin::RelatedSelectInput::ModelData
    include ::RademadeAdmin::RelatedSelectInput::RelatedList

    def input(wrapper_options = {})
      RademadeAdmin::HtmlBuffer.new([select_ui_html, related_html])
    end

    protected

    def select_ui_html
      template.content_tag(
        :div,
        template.text_field_tag(input_html_options_name, '', html_attributes),
        html_attributes
      )
    end

    def related_html
      multiple? ? related_list_html : related_item_html
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

    def reflection_data
      search_url = admin_autocomplete_uri(related_to, :format => :json)
      new_url = admin_new_form_uri(related_to)
      data = {
        :'rel-multiple' => multiple?,
        :'rel-class' => related_to.to_s,
        :editable => options[:editable],
        :destroyable => options[:destroyable],
        :disabled => options[:disabled] || !options[:editable]
      }
      data[:'search-url'] = search_url if search_url
      data[:'new-url'] = new_url if options[:editable] && new_url
      data
    end

    def related_item_html
      if related_value.nil?
        nil
      else
        template.content_tag(:input, '', {
          :type => 'hidden',
          :data => serializer.new([related_value]).as_json.first
        })
      end
    end

    def serializer
      Autocomplete::BaseSerializer
    end

  end
end
