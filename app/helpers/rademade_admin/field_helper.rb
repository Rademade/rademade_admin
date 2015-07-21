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
    value = raw_item_value(item, data_item)
    return (value ? '✔' : '×') if value.is_a?(::Boolean)
    value
  end

  def display_related_item(data_item, item, value)
    if data_item.relation.has_many?
      link_to(data_item.label, admin_related_item(item, data_item.getter))
    else
      link_to(value.to_s, admin_edit_uri(value)) unless value.nil?
    end
  end

  def display_upload_item(_, value)
    RademadeAdmin::Upload::PreviewService.new(value).uploaded_file_html
  end

  def input_attr(attrs = {})
    attrs.deep_merge(
      wrapper_html: { class: 'form-group' },
      input_html: { class: 'form-input' }
    )
  end

  def raw_item_value(item, data_item)
    return data_item.list_preview_handler.call(item) unless data_item.list_preview_handler.nil?
    value = item.send(data_item.list_preview_accessor)
    return display_upload_item(data_item, value) if data_item.has_uploader?
    return display_related_item(data_item, item, value) if data_item.has_relation?
    value.to_s.html_safe
  end

end
