# -*- encoding : utf-8 -*-
module RademadeAdmin
  class RelationService

    def related_model_info(model_info, relation)
      related_model = model_info.data_items.data_item(relation).relation.to
      RademadeAdmin::Model::Graph.instance.model_info(related_model)
    end

  end
end