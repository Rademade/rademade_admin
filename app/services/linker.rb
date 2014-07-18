# -*- encoding : utf-8 -*-
module RademadeAdmin
  class Linker

    def initialize(model_info, parent_model, parent_id)
      @model_info = model_info
      @parent_model_info = RademadeAdmin::Model::Graph.instance.model_info(parent_model)
      @parent = @parent_model_info.model.find(parent_id)
    end

    def link(id)
      process_link { |old_data| old_data << parse_id(id) }
    end

    def unlink(id)
      process_link { |old_data| old_data - [parse_id(id)] }
    end

    private

    def process_link
      related_name = @model_info.model_name.tableize.gsub('/', '_').to_sym # todo extract method or better guessing of related name
      association = @parent_model_info.reflect_on_association(related_name)
      foreign_key = @parent_model_info.association_foreign_key(association)
      @parent.send(foreign_key + '=', yield(@parent.send(foreign_key)))
      @parent.save
    end

    def parse_id(id)
      Integer(id) rescue id.to_s
    end

  end
end
