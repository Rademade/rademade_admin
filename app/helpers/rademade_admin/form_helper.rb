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
        :class => (record.new_record? ? 'insert-item-form' : 'update-item-form')
      },
      &block
    )
  end

  def login_form(&block)
    simple_form_for(
      RademadeAdmin.configuration.admin_class.new,
      :wrapper => :rademade_login,
      :url => [:sessions],
      :as => :data,
      :html => {
        :id => 'login-form',
        :class => 'login-form'
      },
      &block
    )
  end

  def admin_field(form, data_item, model_info)
    if can_read_relation data_item
      name = data_item.name
      attrs = admin_default_params(name, model_info)
        .merge(field_params(data_item))
        .merge(input_params(name))
      concat form.input(name, input_attr(attrs))
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
        :id => "#{name}_#{@item.id}"
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