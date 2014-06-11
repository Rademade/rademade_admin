module RademadeAdmin::NameHelper

  def admin_list_name(model=nil, suffix=true)
    model = @model if model.is_a? NilClass
    "#{model.to_s.pluralize} #{'list' if suffix}"
  end

  def admin_add_name(model)
    model = @model if model.is_a? NilClass
    "Add #{model.to_s.singularize.downcase}"
  end

end