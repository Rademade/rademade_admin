module RademadeAdmin::UriHelper

  def admin_current_page?(uri, model_info = nil)
    (not model_info.nil? and model_info == @model_info) or (not uri.nil? and current_page?(uri))
  end

  def admin_unlink_uri(model, parent, parent_id)
    admin_model_url_for(model.class, {
      :action => :unlink_relation,
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
    admin_model_url_for(model, {
      :action => :autocomplete
    }.merge(opts))
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

  def admin_edit_uri(model)
    entity_url(model, :edit)
  end

  def admin_edit_form_uri(model)
    entity_url(model, :form)
  end

  def admin_delete_uri(model)
    entity_url(model, :destroy)
  end

  def admin_create_uri(model)
    admin_model_url_for(model, {
      :action => :create
    })
  end

  def admin_update_uri(model)
    entity_url(model, :update)
  end

  def admin_model_url_for(model_info, options = {})
    unless model_info.is_a? RademadeAdmin::Model::Info
      model_info = RademadeAdmin::Model::Graph.instance.model_info(model_info)
    end
    options.merge!(get_id(model_info)) if nested?(model_info)
    url_options = options.merge({
      :controller => model_info.controller
    })
    admin_url_for(url_options)
  end

  def admin_url_for(url_options)
    url_options = url_options.merge({
      :only_path => true
    })
    #todo folder of admin controllers
    url_options[:controller] = 'rademade_admin/' + url_options[:controller]
    begin
      Rails.application.routes.url_helpers.url_for(url_options)
    rescue
      begin
        RademadeAdmin::Engine.routes.url_helpers.url_for(url_options)
      rescue
        nil
      end
    end
  end

  private

  def nested?(model_info)
    @object and model_info
  end

  def get_id(model_info)
    key = model_info.model.to_s.foreign_key
    { key.to_sym => @object.id }
  end

  def entity_url(model, action)
    admin_model_url_for(model.class, {
      :action => action,
      :id => model.id
    })
  end

end
