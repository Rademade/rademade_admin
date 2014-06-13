module RademadeAdmin
  class AdminSelectInput < Formtastic::Inputs::SelectInput

    include  ::RademadeAdmin::UriHelper

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
      if multiple?
        builder.object.send(reflection[:name]).pluck(:id).map(&:to_s).join(',')
      else
        builder.object.send(reflection[:name]).try(:id).to_s
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
      template.content_tag(:button, 'Add new', {
        :class => 'relation-add-button',
        'data-new' => new_item_url,
        'data-class' => reflection_class
      })
    end

    def new_item_url
      admin_new_form_uri(reflection_class.constantize)
    end

    def reflection_data
      data = {}
      if related_with_model?
        data.merge!({
          'rel-multiple' => multiple?.to_s,
          'rel-class'    => reflection_class,
          'rel-list-url' => admin_autocomplete_uri(reflection_class, format: :json)
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

  end
end