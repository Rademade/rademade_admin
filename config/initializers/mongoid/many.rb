# encoding: utf-8
module Mongoid
  module Relations
    module Builders
      module Referenced
        class Many

          def build(type = nil)
            return object unless query?
            return [] if object.is_a?(Array)
            criteria = metadata.criteria(Conversions.flag(object, metadata), base.class)
            criteria = criteria.send(metadata.sortable_scope) if metadata.sortable?
            criteria
          end

        end
      end
    end
  end
end