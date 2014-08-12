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
      list_breadcrumbs(true)
      breadcrumbs.add @item.to_s, admin_edit_uri(@item)
      breadcrumbs.add @related_model_info.item_name
    end

  end
end