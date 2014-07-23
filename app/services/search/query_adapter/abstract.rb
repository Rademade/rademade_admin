# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Search
    module QueryAdapter
      class Abstract

        def initialize(model)
          @model = model
        end

        def apply_conditions(search_conditions)
          @params = search_conditions.params
          @result = search_conditions.base_condition(@model)

          search_conditions.conditions.each do |query_part, values|
            @result = self.send(query_part, values) unless values.nil?
          end

          @result
        end

        protected

        def where(where_conditions)
          @result
        end

        def order(order_conditions)
          @result
        end

        def page(page_condition)
          @result.page(page_condition)
        end

        def per_page(per_page_condition)
          @result.per(per_page_condition)
        end

        def limit(limit_condition)
          @result.limit(limit_condition)
        end

      end
    end
  end
end
