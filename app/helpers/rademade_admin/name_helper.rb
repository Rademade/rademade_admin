module RademadeAdmin::NameHelper

  def admin_list_name(model = nil, suffix = true)
    model ||= @model
    list_name = model.to_s.pluralize
    list_name += ' list' if suffix
    list_name
  end

  def admin_add_name(model)
    model ||= @model
    "Add #{model.to_s.singularize.downcase}"
  end

end