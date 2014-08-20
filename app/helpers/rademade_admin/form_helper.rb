# -*- encoding : utf-8 -*-
module RademadeAdmin::FormHelper

  def admin_form(record, model, &block)
    simple_form_for(
      record,
      :wrapper => :rademade,
      :url => record.new_record? ? admin_create_uri(model) : admin_update_uri(record),
      :as => :data,
      :html => {
        :multipart => true,
        :novalidate => true,
        :autocomplete => 'off',
        :class => (record.new_record? ? 'insert-item-form' : 'update-item-form') + ' form-horizontal',
      },
      &block
    )
  end

  def admin_field(form, form_field, model_info)
    name = form_field.name
    attrs = admin_default_params(name, model_info).merge(field_params(form_field))
    concat form.input(name, input_attr(attrs))
  end

  private

  def admin_default_params(name, model_info)
    { :label => model_info.label_for(name) }
  end

  def field_params(form_field)
    field_params = form_field.form_params
    field_params[:as] = default_field_type(form_field) unless field_params[:as].present?
    field_params
  end

  def default_field_type(form_field)
    if form_field.has_relation?
       :'rademade_admin/related_select'
    elsif form_field.has_uploader?
       :'rademade_admin/file'
    else
       nil
    end
  end

end