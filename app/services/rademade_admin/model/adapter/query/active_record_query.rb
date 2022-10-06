# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query
        class ActiveRecordQuery < RademadeAdmin::Model::Adapter::Query::SqlQuery

          def find(ids)
            @model.find(ids)
          end

          def initial
            @model.unscoped
          end

          protected

          def order(order_conditions)
            order_conditions.parts.each do |part|
              if part.is_a? RademadeAdmin::Search::Part::Order
                # todo
              else
                @result = @result.order(part[:field] => part[:value])
              end
            end
            @result
          end

          def paginate(page_condition, per_page_condition)
            @result.page(page_condition).per(per_page_condition)
          end

        end
      end
    end
  end
end
