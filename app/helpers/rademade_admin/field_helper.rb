# -*- encoding : utf-8 -*-
module RademadeAdmin::FieldHelper

  include ActionView::Helpers::TagHelper

  # Display the field of given item
  #
  # @param item [Object]
  # @param data_item [RademadeAdmin::Model::Info::DataItem]
  #
  # @return [String]
  #
  def display_item_value(item, data_item)
    if data_item.list_preview_handler.nil?
      value = item.send(data_item.list_preview_accessor)
      return display_upload_item(value) if data_item.has_uploader?
      return display_related_item(data_item, item, value) if data_item.has_relation?
    else
      value = data_item.list_preview_handler.call(item)
    end
    return display_boolean_item(value) if value.is_a?(::Boolean)
    value.to_s.html_safe
  end

  def display_boolean_item(value)
    content_tag(:span, '', :class => value ? 'checked' : 'rejected')
  end

  def display_related_item(data_item, item, value)
    if data_item.relation.has_many?
      link_to(data_item.label, admin_related_item(item, data_item.getter))
    else
      link_to(value.to_s, admin_edit_uri(value)) unless value.nil?
    end
  end

  def display_upload_item(value)
    RademadeAdmin::Upload::PreviewService.new(value).uploaded_file_html
  end

  def input_attr(attrs = {})
    attrs.deep_merge(
      :wrapper_html => { :class => 'form-group' },
      :input_html => { :class => 'form-input' }
    )
  end

end