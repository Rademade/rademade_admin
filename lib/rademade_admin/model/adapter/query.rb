# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query

        def initialize(model)
          @model = model
        end

        #
        # @param search_conditions [RademadeAdmin::Search::Conditions::Abstract]
        #
        def exec_query(search_conditions)
          @result = search_conditions.base_condition(@model)

          return nil if @result.nil?

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
