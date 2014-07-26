# -*- encoding : utf-8 -*-
module RademadeAdmin::FieldHelper

  def field_to_label(field, model_info = @model_info)
    model_info.fields.label_for(field)
  end

  def field_name(field)
    configured_field?(field) ? field.keys.first : field
  end

  def pagination_option(number, name = 'paginate')
    hash_params = request.query_parameters.clone
    hash_params.delete(:page)
    hash_params[name.to_sym] = number

    options = '?' + hash_params.map { |k, v| "#{k.to_s}=#{v}" }.join('&')
    selected = number == request.query_parameters[name.to_sym].to_i

    content_tag(:option, number.to_s, selected: selected, value: request.path + options)
  end

  def input_attr(attrs = {})
    attrs.merge :wrapper_html => {:class => 'form-group'},
                :input_html => {:class => 'form-control'}
  end

  private

  def configured_field?(field)
    field.is_a? Hash
  end

end
