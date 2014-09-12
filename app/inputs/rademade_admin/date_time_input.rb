# -*- encoding : utf-8 -*-
module RademadeAdmin
  class DateTimeInput < SimpleForm::Inputs::DateTimeInput

    def input
      hidden_input_html + template.content_tag(
        :div,
        HtmlBuffer.new([input_html]),
        :data => { 'date-time-picker' => '' }
      )
    end

    private

    def input_html
      template.content_tag(:input, '', {
        :type => :text,
        :class => 'form-input'
      })
    end

    def hidden_input_html
      @builder.hidden_field(attribute_name, input_html_options)
    end

  end
end