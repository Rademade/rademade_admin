# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Linker

    def initialize(model_info, item, relation_getter)
      @model_info = model_info
      @item = item
      @relation_getter = relation_getter
    end

    def link(id)
      process_link { |old_data| old_data << id }
    end

    def unlink(id)
      process_link { |old_data| old_data - [id] }
    end

    private

    def process_link
      relation_field = @model_info.relations.relation(@relation_getter)
      old_data = @item.send(relation_field.id_getter).map(&:to_s) # todo check for active record
      @item.send(relation_field.id_setter, yield(old_data))
      @item.save
    end

  end
end
