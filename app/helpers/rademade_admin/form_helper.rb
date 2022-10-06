# -*- encoding : utf-8 -*-
module RademadeAdmin::FormHelper

  def admin_form(record, model_info, &block)
    simple_form_for(record, admin_form_options(record, model_info), &block)
  end

  def login_form(&block)
    admin_model_info = RademadeAdmin::Model::Graph.instance.model_info(RademadeAdmin.configuration.admin_class)
    simple_form_for(admin_model_info.persistence_adapter.new_record, login_form_options, &block)
  end

  def admin_field(form, data_item, model_info)
    if can_read? data_item
      name = data_item.name
      attrs = admin_default_params(name, model_info)
        .merge(field_params(data_item))
        .deep_merge(input_params(name))
      concat form.input(name, {
        addable: can?(:create, @item) && (!data_item.has_relation? || can?(:create, data_item.relation.to)),
        editable: can?(:update, @item) && (!data_item.has_relation? || can?(:update, data_item.relation.to)),
        destroyable: can?(:destroy, @item) || (data_item.has_relation? && can?(:destroy, data_item.relation.to)),
        disabled: !can?(:update, @item)
      }.merge(input_attr(attrs)))
    end
  end

  def admin_localized_field(form, data_item, model_info, locale)
    name = "#{data_item.getter}][#{locale}"
    attrs = admin_default_params(data_item.name, model_info)
      .merge(field_params(data_item))
      .merge(localized_field_params(data_item, locale))
    concat form.input(name, input_attr(attrs))
  end

  private

  def admin_form_options(record, model_info)
    if model_info.persistence_adapter.new?(record)
      url = admin_create_uri(model_info)
      form_class = 'insert-item-form'
      method = :post
      save_type = :create
      id = nil
    else
      url = admin_update_uri(record)
      form_class = 'update-item-form'
      method = :patch
      save_type = :update
      id = record.id
    end
    {
      :wrapper => :rademade,
      :url => url,
      :method => method,
      :as => :data,
      :html => admin_form_html_attributes(form_class),
      :data => {
        :method => method,
        :model => record.model.to_s,
        :save_type => save_type,
        :id => id
      }
    }
  end

  def login_form_options
    {
      :wrapper => :rademade_login,
      :url => [:sessions],
      :as => :data,
      :html => {
        :id => 'login-form',
        :class => 'login-form'
      }
    }
  end

  def admin_form_html_attributes(form_class)
    {
      :multipart => true,
      :novalidate => true,
      :autocomplete => 'off',
      :class => form_class
    }
  end

  def admin_default_params(name, model_info)
    { :label => model_info.label_for(name) }
  end

  def field_params(data_item)
    field_params = data_item.form_params
    field_params[:as] = field_type(data_item, field_params[:as])
    field_params
  end

  def input_params(name)
    {
      :input_html => {
        :id => "#{name}_#{@item.id || unique_pseudo_id}"
      }
    }
  end

  def localized_field_params(data_item, locale)
    {
      :input_html => {
        :id => "#{data_item.getter}_#{locale}_#{@item.id || unique_pseudo_id}",
        :value => localized_value(data_item.getter, locale)
      }
    }
  end

  private

  # generate pseudo id for records without id (not created yet)
  def unique_pseudo_id
    DateTime.now.strftime('%Q') + rand.to_s
  end

  def localized_value(getter, locale)
    current_locale = I18n.locale
    I18n.locale = locale
    item_value = (@item.try(:translation) || @item).send(getter)
    I18n.locale = current_locale
    item_value
  end

  def can_read?(data_item)
    can?(:access_field, @item, data_item.name) && (!data_item.has_relation? || can?(:read, data_item.relation.to))
  end

end
