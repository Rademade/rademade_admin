# -*- encoding : utf-8 -*-
module RademadeAdmin::PaginationHelper

  def on_page_item(on_page, index, name = :paginate)
    hash_params = request.query_parameters.clone.except(:page, :layout)
    hash_params[name] = on_page

    content_tag(:span, on_page.to_s,
      :class => on_page_item_class(on_page, request.query_parameters[name], index),
      :'data-link-url' => admin_url_for(request.path_parameters.merge(hash_params))
    )
  end

  private

  def on_page_item_class(on_page, chosen_on_page, index)
    class_name = 'btn-switch-item'
    if (chosen_on_page.nil? && index.zero?) || on_page == chosen_on_page.to_i
      class_name += ' is-active'
    end
    class_name
  end

end
