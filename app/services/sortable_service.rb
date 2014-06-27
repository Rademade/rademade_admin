class RademadeAdmin::SortableService

  def initialize(model_info, params)
    @model_info = model_info
    @params = params
  end

  def re_sort_items
    min = @params[:minimum].to_i
    @params[:sorted].each do |k, v|
      item = @model_info.find(v[0])
      item.position = k.to_i + 1 + min
      item.save
    end
  end

  def can_reset?
    @params[:sort].present?
  end

  def sorting_sign(name)
    if name.to_s == @params[:sort]
      case @params[:direction]
        when 'asc'
          return '⬇'
        when 'desc'
          return '⬆'
      end
    end
    ''
  end

  def has_position?
    @model_info.has_field? 'position'
  end

end