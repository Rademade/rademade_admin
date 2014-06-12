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
    admin_url_for(model.class, {
      :action => :edit,
      :id => model.id
    })
  end

  def admin_edit_form_uri(model)
    admin_url_for(model.class, {
      :action => :form,
      :id => model.id
    })
  end

  def admin_delete_uri(model)
    admin_url_for(model.class, {
      :action => :destroy,
      :id => model.id
    })
  end

  def admin_create_uri(model_name)
    admin_url_for(model_name, {
      :action => :create
    })
  end

  def admin_update_uri(model)
    admin_url_for(model.class, {
      :action => :update,
      :id => model.id
    })
  end

  def admin_url_for(model_name, options = {})
    options.merge!(get_id) if nested?(model_name)

    Rails.application.routes.url_helpers.url_for(options.merge({
      :controller => model_to_controller(model_name),
      :only_path => true
    }))
  end


  def model_to_controller(model_name)
    'rademade_admin/' + ::ModelGraph.instance.model_info(model_name).controller
  end

  private
    def nested?(model_name)
      @object && ::ModelGraph.instance.model_info(model_name).nested?
    end

  def get_id
    key = model_name.foreign_key
    {key.to_sym => @object.id}
  end

end
