# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Linker

    def initialize(model_info, item, relation)
      @model_info = model_info
      @item = item
      @related_data_item = model_info.data_items.data_item(relation)
    end

    def link(id)
      process_link { |old_data| old_data << @related_data_item.relation.related_entities(id) }
    end

    def unlink(id)
      process_link { |old_data| old_data - [@related_data_item.relation.related_entities(id)] }
    end

    private

    def process_link
      old_data = @item.send(@related_data_item.getter).to_a
      @item.send(@related_data_item.setter, yield(old_data))
      @item.save
    end

  end
end
