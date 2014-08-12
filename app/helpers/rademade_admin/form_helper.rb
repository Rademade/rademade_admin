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

    field = form.input(name, input_attr(attrs))

    relation = form_field.relation
    if relation and relation.many?
      relation_name = RademadeAdmin::Model::Graph.instance.model_info(relation.to).item_name
      #rm_todo Лучше эту ссылку перенести в сам AdminSelectInput
      field += link_to relation_name, admin_related_item(form.object, relation.getter)
    end

    concat field
  end

  def admin_default_params(name, model_info)
    { :label => model_info.label_for(name) }
  end

end