# -*- encoding : utf-8 -*-
module RademadeAdmin::FormHelper

  def admin_form(record, model, &block)
    semantic_form_for(
      record,
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
    attrs = admin_default_params(name, model_info).merge(admin_form_params(form_field))
    concat form.input(name, input_attr(attrs))
  end

  def admin_default_params(name, model_info)
    { :label => model_info.label_for(name) }
  end

  def admin_form_params(form_field)
    params = form_field.form_params
    unless params[:as].present?
      params[:as] = default_field_type(form_field)
    end
    params
  end

  private

  def default_field_type(form_field)
    if form_field.relation
       :'rademade_admin/admin_select'
    #elsif @model_info.uploader_fields.include? form_field.name # todo
    #   :'rademade_admin/admin_file'
    else
       nil
    end
  end

end
