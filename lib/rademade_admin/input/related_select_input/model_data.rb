# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Input
    class RelatedSelectInput
      module ModelData

        private

        def model
          @model ||= @builder.object
        end

        def related_data_item
          unless @related_data_item
            model_info = Model::Graph.instance.model_info(model.class)
            @related_data_item = model_info.data_items.data_item(attribute_name)
          end
          @related_data_item
        end

        def related_to
          related_data_item.relation.to
        end

        def relation_getter
          related_data_item.getter
        end

        def multiple?
          related_data_item.relation.many?
        end

        def related_value
          @related_value ||= model.send(relation_getter)
        end

      end
    end
  end
end