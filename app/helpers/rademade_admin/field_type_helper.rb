# -*- encoding : utf-8 -*-
module RademadeAdmin::FieldTypeHelper

  def field_type(data_item, type)
    if type.nil?
      default_field_type(data_item)
    else
      rademade_admin_type(type)
    end
  end

  def default_field_type(data_item)
    if data_item.gallery_relation?
      :'rademade_admin/gallery'
    elsif data_item.has_relation?
      :'rademade_admin/related_select'
    elsif data_item.has_uploader?
      :'rademade_admin/file'
    elsif data_item.date_time_field?
      :'rademade_admin/date_time'
    elsif data_item.boolean_field?
      rademade_admin_boolean_type
    else
      nil
    end
  end

  def rademade_admin_type(type)
    if type == :boolean
      rademade_admin_boolean_type
    else
      type
    end
  end

  def rademade_admin_boolean_type
    :'rademade_admin/boolean'
  end

end