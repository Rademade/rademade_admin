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

  def admin_field(form, name, params, model_info)
    field_params = admin_field_params(params, model_info)
    attrs = admin_default_params(name, model_info).merge( field_params )
    concat form.input(name, input_attr(attrs))
  end

  def admin_default_params(name, model_info)
    {
      :label => field_to_label(name, model_info)
    }
  end

  def admin_field_params(params, model_info)
    if params.is_a? Hash
      params
    else
      #todo it's very riskly. Needs more clearer
      { :as => params }
    end
  end

  # todo move to other helper!
  def default_field_type(field)
    # if @data_adapter.association_fields.include? field
    #   'rademade_admin/admin_select'
    # elsif @data_adapter.uploader_fields.include? field
    #   'rademade_admin/admin_file'
    # else
    #   nil
    # end
  end

end
