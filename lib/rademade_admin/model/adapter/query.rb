# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query

        def initialize(model)
          @model = model
        end

        # @param [RademadeAdmin::Search::Conditions::Abstract] search_conditions
        def exec_query(search_conditions)
          @result = search_conditions.base_condition(initial)
          return nil if @result.nil?
          search_conditions.conditions.each do |query_part, values|
            @result = self.send(query_part, *values) unless values.nil?
          end
          @result
        end

        def find(id)
          nil
        end

        def initial
          []
        end

        protected

        def where(where_conditions)
          @result
        end

        def order(order_conditions)
          @result
        end

        def paginate(page_condition, per_page_condition)
          @result
        end

        def limit(limit_condition)
          @result.limit(limit_condition)
        end

      end
    end
  end
end