# -*- encoding : utf-8 -*-
module RademadeAdmin::FormHelper

  def admin_form(record, model_info, &block)
    simple_form_for(record, admin_form_options(record, model_info), &block)
  end

  def login_form(&block)
    admin_model_info = RademadeAdmin::Model::Graph.instance.model_info(RademadeAdmin.configuration.admin_class)
    simple_form_for(admin_model_info.persistence_adapter.new_record, login_form_options, &block)
  end

  def filter_form(model_info, &block)
    simple_form_for(model_info.model.to_s.underscore.to_sym, filter_form_options(model_info), &block)
  end

  def admin_field(form, data_item, model_info, additional_params = {}, disallowed_types = [])
    return unless can_read_relation data_item
    field_params = field_params(data_item)
    return if disallowed_types.include? field_params[:as]
    name = data_item.name
    attrs = admin_default_params(name, model_info)
      .merge(field_params)
      .merge(input_params(name))
      .merge(additional_params)
    concat form.input(name, input_attr(attrs))
  end

  def admin_localized_field(form, data_item, model_info, locale)
    name = "#{data_item.getter}][#{locale}"
    attrs = admin_default_params(data_item.name, model_info)
      .merge(field_params(data_item))
      .merge(localized_field_params(data_item, locale))
    concat form.input(name, input_attr(attrs))
  end

  def admin_filter_field(form, data_item, model_info, value)
    admin_field(form, data_item, model_info, filter_field_params(data_item, value), [
      :'rademade_admin/location',
      :'rademade_admin/boolean'
    ])
  end

  private

  def admin_form_options(record, model_info)
    if model_info.persistence_adapter.new?(record)
      url = admin_create_uri(model_info)
      form_class = 'insert-item-form'
      method = :post
    else
      url = admin_update_uri(record)
      form_class = 'update-item-form'
      method = :patch
    end
    {
      :wrapper => :rademade,
      :url => url,
      :method => method,
      :as => :data,
      :html => admin_form_html_attributes(form_class)
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

  def filter_form_options(model_info)
    {
      :wrapper => :rademade,
      :url => admin_list_uri(model_info),
      :method => :get,
      :enforce_utf8 => false,
      :data => {
        :form => 'filter',
        :disable_admin => true,
        :turboform => true
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
        :id => "#{name}_#{@item.try(:id)}"
      }
    }
  end

  def localized_field_params(data_item, locale)
    {
      :input_html => {
        :id => "#{data_item.getter}_#{locale}_#{@item.id}",
        :value => localized_value(data_item.getter, locale)
      }
    }
  end

  def filter_field_params(data_item, value)
    filter_field_params = {
      :required => false,
      :hint => nil,
      :selected => value,
      :input_html => {
        :name => data_item.name,
        :value => value
      }
    }
    filter_field_params.merge!({
      :relation_from => data_item.relation.from,
      :with_related_edit => false
    }) if data_item.has_relation?
    filter_field_params
  end

  private

  def localized_value(getter, locale)
    current_locale = I18n.locale
    I18n.locale = locale
    item_value = (@item.try(:translation) || @item).send(getter)
    I18n.locale = current_locale
    item_value
  end

  def can_read_relation(data_item)
    !data_item.has_relation? || can?(:read, data_item.relation.to)
  end

end