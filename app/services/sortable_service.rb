# -*- encoding : utf-8 -*-
module RademadeAdmin
  class SortableService

    def initialize(model_info, params)
      @model_info = model_info
      @params = params
    end

    def sort_items
      min = @params[:minimum].to_i
      @params[:sorted].each do |k, v|
        item = @model_info.model.find(v[0])
        item.position = k.to_i + 1 + min
        item.save
      end
    end

    def can_reset?
      @params[:sort].present?
    end

    #
    # @return [RademadeAdmin::Model::Info::DataItem]
    #
    def sorting_sign(field)
      if field.name.to_s == @params[:sort]
        return '⬇' if @params[:direction] == 'asc'
        return '⬆' if @params[:direction] == 'desc'
      end
      ''
    end

    def has_position?
      @model_info.data_items.has_field? 'position'
    end

  end
end
