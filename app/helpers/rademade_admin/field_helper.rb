# -*- encoding : utf-8 -*-
module RademadeAdmin::FieldHelper

  def field_to_label(field)
    if configured_field?(field) and field.values.first[:label].present?
      field.values.first[:label]
    else
      field.to_s.humanize
    end
  end

  def field_name(field)
    configured_field?(field) ? field.keys.first : field
  end

  def field_value(field, item)
    if configured_field?(field)
      if field.values.first[:method].present?
        method_name = field.values.first[:method]
      else
        method_name = field.keys.first
      end
    else
      method_name = field
    end
    item.send(method_name)
  end

  def pagination_option(number, name = 'paginate')
    hash_params = request.query_parameters.clone
    hash_params.delete(:page)
    hash_params[name.to_sym] = number

    options = '?' + hash_params.map do |k, v|
      "#{k.to_s}=#{v}"
    end.join('&')

    selected = number == request.query_parameters[name.to_sym].to_i

    content_tag(:option, number.to_s, selected: selected, value: request.path+options)
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
