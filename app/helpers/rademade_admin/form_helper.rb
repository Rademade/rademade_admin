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
    attrs = admin_default_params(name, model_info).merge(form_field.form_params)
    concat form.input(name, input_attr(attrs))
  end

  def admin_default_params(name, model_info)
    { :label => model_info.label_for(name) }
  end

end