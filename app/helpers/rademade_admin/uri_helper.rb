# -*- encoding : utf-8 -*-
module RademadeAdmin::UriHelper

  def root_uri
    rademade_admin_route(:root_url)
  end

  def rademade_admin_route(route_url, opts = {})
    opts[:only_path] = true
    RademadeAdmin::Engine.routes.url_helpers.send(route_url, opts)
  end

  def admin_list_uri(model, opts = {})
    admin_model_url_for(model, opts.merge({
      :action => :index
    }))
  end

  def admin_autocomplete_uri(model, opts = {})
    admin_model_url_for(model, opts.merge({
      :action => :autocomplete
    }))
  end

  def admin_new_uri(model)
    admin_model_url_for(model, {
      :action => :new
    })
  end

  def admin_new_form_uri(model)
    admin_model_url_for(model, {
      :action => :form
    })
  end

  def admin_create_uri(model)
    admin_model_url_for(model, {
      :action => :create
    })
  end

  def admin_edit_uri(model)
    _entity_url(model, :edit)
  end

  def admin_edit_form_uri(model)
    _entity_url(model, :form)
  end

  def admin_delete_uri(model)
    _entity_url(model, :destroy)
  end

  def admin_update_uri(model)
    _entity_url(model, :update)
  end

  def admin_model_url_for(model, opts = {})
    model_info = _real_model_info(model)
    admin_url_for(opts.merge({
      :controller => "#{model_info.module_name}/#{model_info.controller}"
    }))
  end

  def admin_url_for(opts)
    opts[:only_path] = true
    Rails.application.routes.url_helpers.url_for(opts)
  rescue
    RademadeAdmin::Engine.routes.url_helpers.url_for(opts) rescue nil
  end

  private

  def _entity_url(model, action, opts = {})
    admin_model_url_for(model.class, opts.merge({
      :action => action,
      :id => model.id
    }))
  end

  def _real_model_info(model)
    return model if model.is_a? RademadeAdmin::Model::Info
    RademadeAdmin::Model::Graph.instance.model_info(model)
  end

end