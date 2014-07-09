module RademadeAdmin::UriHelper

  def admin_current_page?(uri, model_name = nil)
    (not model_name.nil? and model_name == @model) or current_page?(uri)
  end

  def admin_unlink_uri(model, parent, parent_id)
    admin_url_for(model.class, {
      :action => :unlink_relation,
      :id => model.id,
      :parent => parent,
      :parent_id => parent_id
    })
  end

  def admin_list_uri(model_name)
    admin_url_for(model_name, {
      :action => :index
    })
  end

  def admin_autocomplete_uri(model_name, opts = {})
    admin_url_for(model_name, {
      :action => :autocomplete
    }.merge(opts))
  end

  def admin_new_uri(model_name)
    admin_url_for(model_name, {
      :action => :new
    })
  end

  def admin_new_form_uri(model_name)
    admin_url_for(model_name, {
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

  def admin_create_uri(model_name)
    admin_url_for(model_name, {
      :action => :create
    })
  end

  def admin_update_uri(model)
    entity_url(model, :update)
  end

  def admin_url_for(model_name, options = {})
    options.merge!(get_id(model_name)) if nested?(model_name)

    url_options = options.merge({
      :controller => model_to_controller(model_name),
      :only_path => true
    })
    begin
      url = RademadeAdmin::Engine.routes.url_helpers.url_for(url_options)
    rescue
      url = Rails.application.routes.url_helpers.url_for(url_options)
    end

    url
  end

  def model_to_controller(model_name)
    #todo folder of admin controllers
    'rademade_admin/' + RademadeAdmin::Model::Graph.instance.model_info(model_name).controller
  end

  private

  def nested?(model_name)
    @object and RademadeAdmin::Model::Graph.instance.model_info(model_name)
  end

  def get_id(model_name)
    key = model_name.to_s.foreign_key
    { key.to_sym => @object.id }
  end

  def entity_url(model, action)
    admin_url_for(model.class, {
      :action => action,
      :id => model.id
    })
  end

end
