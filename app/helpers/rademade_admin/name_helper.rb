module RademadeAdmin::NameHelper

  def admin_list_name(model_info = @model_info, suffix = true)
    list_name = model_info.item_name
    if suffix
      list_name += ' list'
    else
      list_name = list_name.pluralize
    end
    list_name
  end

  def admin_add_name(model_info = @model_info)
    "Add #{model_info.item_name.downcase}"
  end

end