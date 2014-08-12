# -*- encoding : utf-8 -*-
module RademadeAdmin::UriHelper

  def admin_link_uri(model, parent, parent_id)
    admin_model_url_for(model.class, {
      :action => :link_relation,
      :id => model.id,
      :parent => parent,
      :parent_id => parent_id
    })
  end

  def admin_list_uri(model)
    admin_model_url_for(model, {
      :action => :index
    })
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

  def admin_related_item(model, relation_getter, opts = {})
    _entity_url(model, :related, opts.merge({
      :relation => relation_getter
    }))
  end

  def admin_unlink_uri(model, relation_getter, opts = {})
    _entity_url(model, :related_destroy, opts.merge({
      :relation => relation_getter
    }))
  end

  def admin_model_url_for(model_info, opts = {})
    admin_url_for(opts.merge({
      :controller => _real_model_info(model_info).controller
    }))
  end

  def admin_url_for(opts)
    opts = opts.merge({
      :controller => 'rademade_admin/' + opts[:controller],
      :only_path => true
    })
    begin
      Rails.application.routes.url_helpers.url_for(opts)
    rescue
      begin
        RademadeAdmin::Engine.routes.url_helpers.url_for(opts)
      rescue
        nil
      end
    end
  end

  private

  def _entity_url(model, action, opts = {})
    admin_model_url_for(model.class, opts.merge({
      :action => action,
      :id => model.id
    }))
  end

  def _real_model_info(model_info)
    unless model_info.is_a? RademadeAdmin::Model::Info
      model_info = RademadeAdmin::Model::Graph.instance.model_info(model_info)
    end
    model_info
  end

end
