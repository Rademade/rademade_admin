module RademadeAdmin::FormHelper
  def admin_form(record, model, &block)
    semantic_form_for(
      record,
      :url => record.new_record? ? admin_create_uri(model) : admin_update_uri(record),
      :as => :data,
      :html => {
        :multipart => true,
        :class => (record.new_record? ? 'insert-item-form' : 'update-item-form') + ' form-horizontal',
      },
      &block
    )
  end

  def admin_field(form, name, field_params, model, record)
    input_attrs = admin_field_label(name)

    input_attrs = admin_field_set_attrs(input_attrs, field_params)

    field = form.input(name, input_attr(input_attrs))

    link = admin_field_link_to_list(name, model, record) if multiple_relation?(model, name)

    concat field + link.to_s
  end

  def admin_field_label(name)
    { :label => field_to_label(name) }
  end

  def admin_field_link_to_list(name, model, record)
    uri = admin_url_for(model.reflect_on_association(name).class_name, {
      :action => :index,
      :parent => model,
      :parent_id => record.id.to_s
    })
    link_to(field_to_label(name).pluralize + ' list', uri)
  end

  def admin_field_set_attrs(input, field_params)
    if field_params.is_a? Hash
      input.merge!(field_params)
    else
      input[:as] = field_params
    end

    input
  end

  private

  def multiple_relation?(model, name)
    association = model.reflect_on_association(name)
    if association
      inner_model = association.class_name.to_s
      ModelGraph.instance.model_info(model).has_many.include? inner_model
    end
  end

end