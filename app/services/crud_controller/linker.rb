module RademadeAdmin::CrudController::Linker
  def link(item)
    unless has_one_relation?
      old_data = get_attribute(item)
      old_data << params[:parent_id]

      set_attribute(item, old_data)
    else
      set_attribute(item, params[:parent_id])
    end

    item.save
  end

  def unlink(item)
    item = model_class.find(params[:id])

    unless has_one_relation?
      old_data = get_attribute(item)
      new_data = old_data - Array(params[:parent_id])

      set_attribute(item, new_data)
    else
      set_attribute(item, nil)
    end

    item.save
  end

  private

  def has_one_relation?
    ModelGraph.instance.model_info(model_class.to_s).has_one.include? params[:parent]
  end

  def relation_suffix
    has_one_relation? ? '_id' : '_ids'
  end

  def get_attribute(item)
    item.send(relation_field)
  end

  def relation_field
    params[:parent].downcase + relation_suffix
  end

  def set_attribute(item, new_value)
    item.send(relation_field + '=', new_value)
  end

end