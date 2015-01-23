# -*- encoding : utf-8 -*-
module RademadeAdmin
  class SortableService

    def initialize(model_info, params)
      @model_info = model_info
      @params = params
    end

    def sort_items
      @params[:sorted].each do |_, sorted_data|
        item = @model_info.query_adapter.find(sorted_data[:id])
        item.position = sorted_data[:position].to_i
        item.save
      end
    end

    def can_reset?
      @params[:sort].present?
    end

    def sorting_sign(field)
      if field.order_column.to_s == @params[:sort]
        return '⬇' if @params[:direction] == 'asc'
        return '⬆' if @params[:direction] == 'desc'
      end
      ''
    end

    def has_position?
      @model_info.data_items.has_field? :position
    end

  end
end
