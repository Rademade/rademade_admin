module RademadeAdmin
  class Linker

    def initialize(model_info, parent_model, parent_id)
      @model_info = model_info
      @parent_model_info = RademadeAdmin::Model::Graph.instance.model_info(parent_model)
      @parent = @parent_model_info.model.find(parent_id)
    end

    def link(id)
      process_link { |old_data| old_data << id.to_i }
    end

    def unlink(id)
      process_link { |old_data| old_data - [id.to_i] }
    end

    private

    def process_link
      related_name = @model_info.model_name.downcase.pluralize.to_sym
      association = @parent_model_info.reflect_on_association(related_name)
      foreign_key = @parent_model_info.association_foreign_key(association)
      @parent.send(foreign_key + '=', yield(@parent.send(foreign_key)))
      @parent.save
      @parent
    end

  end
end