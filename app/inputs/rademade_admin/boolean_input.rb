module RademadeAdmin
  class BooleanInput < Formtastic::Inputs::BooleanInput

    def label_with_nested_checkbox
      builder.label(
        method,
        label_text,
        label_html_options
      ) + check_box_html
    end

  end
end