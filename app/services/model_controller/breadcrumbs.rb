module RademadeAdmin
  module Breadcrumbs
   
    def root_breadcrumbs
      breadcrumbs.add t('rademade_admin.dashboard'), root_path
    end

    def list_breadcrumbs(with_url = false)
      breadcrumbs.add model_info.item_name, with_url ? admin_list_uri(model) : nil
    end

    def new_breadcrumbs
      list_breadcrumbs(true)
      breadcrumbs.add t('rademade_admin.new_record')
    end

    def edit_breadcrumbs
      list_breadcrumbs(true)
      breadcrumbs.add @item.to_s
    end

    def related_breadcrumbs
      breadcrumbs.add @parent_model_info.item_name, admin_list_uri(@parent_model_info)
      breadcrumbs.add @parent, admin_model_url_for(params[:parent], {
        :action => :edit,
        :id => params[:parent_id]
      })
      breadcrumbs.add @model_info.item_name
    end

  end
end