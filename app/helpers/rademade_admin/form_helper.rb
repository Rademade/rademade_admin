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

  def admin_field(form, name, params, model_info, record)
    attrs = admin_default_params(name).merge(admin_field_params(params))

    field = form.input(name, input_attr(attrs))

    if model_info.model_reflection.many_relation? name
      link = admin_field_link_to_list(name, model_info, record).to_s
    else
      link = ''
    end

    concat field + link
  end

  def admin_default_params(name)
    {:label => field_to_label(name)}
  end

  def admin_field_link_to_list(name, model_info, record)
    related_model = model_info.reflect_on_association(name).class_name
    uri = admin_model_url_for(related_model, {
      :action => :related_index,
      :parent => model_info.model,
      :parent_id => record.id.to_s
    })
    link_to(RademadeAdmin::Model::Graph.instance.model_info(related_model).item_name + ' list', uri)
  end

  def admin_field_params(field_params)
    if field_params.is_a? Hash
      field_params
    else
      {:as => field_params}
    end
  end

end