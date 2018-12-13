# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Status
    class Toggler

      attr_reader :item

      def initialize(model, id)
        @model = model
        @id = id
      end

      def init_item
        @model_info = RademadeAdmin::Model::Graph.instance.model_info @model
        @item = @model_info.model.find @id
      end

      def toggle
        if @model_info.hideable?
          @item.toggle
          @item.save
        end
      end

    end
  end
end