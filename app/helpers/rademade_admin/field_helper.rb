# -*- encoding : utf-8 -*-
module RademadeAdmin::FieldHelper

  # Display the field of given item
  #
  # @param item [Object]
  # @param data_item [RademadeAdmin::Model::Info::DataItem]
  #
  # @return [String]
  #
  def display_item_value(item, data_item)
    value = item.send(data_item.list_preview_accessor)
    if data_item.has_relation?
      # rm_todo extract method
      if data_item.relation.has_many?
        link_to data_item.label, admin_related_item(item, data_item.getter)
      else
        link_to value.to_s, admin_edit_uri(value) unless value.nil?
      end
    elsif data_item.has_uploader?
      RademadeAdmin::Upload::PreviewService.new(value).uploaded_file_html
    else
      value.to_s.html_safe
    end
  end

  def pagination_option(number, name = 'paginate')
    hash_params = request.query_parameters.clone
    hash_params.delete(:page)
    hash_params[name.to_sym] = number

    selected = number == request.query_parameters[name.to_sym].to_i
    url_params = request.path_parameters.merge(hash_params)
    content_tag(:option, number.to_s, :selected => selected, :value => admin_url_for(url_params))
  end

  def input_attr(attrs = {})
    attrs.deep_merge :wrapper_html => { :class => 'form-group' },
                :input_html => { :class => 'form-input' }
  end

end
