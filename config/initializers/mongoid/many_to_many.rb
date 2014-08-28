# encoding: utf-8
module Mongoid
  module Relations
    module Builders
      module Referenced
        class ManyToMany < Builder

          def build(type = nil)
            return object.try(:dup) unless query?
            ids = object || []
            criteria = metadata.criteria(ids, base.class)
            criteria.add_filter { |entities| sorted_entities(entities, ids) } if metadata.sortable?
            criteria
          end

          private

          def sorted_entities(entities, sorted_ids)
            entities_hash = {}
            entities.each do |entity|
              entities_hash[entity.id] = entity
            end
            sorted_ids.map { |id| entities_hash[id] }
          end

        end
      end
    end
  end
end