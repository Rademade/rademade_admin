# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query
        class SequelQuery < RademadeAdmin::Model::Adapter::Query::SqlQuery

          def find(ids)
            @model[ids]
          end

          def initial
            @model.dataset
          end

          protected

          def build_where_condition(field: nil, value: nil)
            field = table_field(field)
            if value.is_a? Regexp
              ["LOWER(#{field}) ~* ?", [value.source]]
            elsif value.is_a? Array
              ["#{field} IN (?)", [value]]
            else
              ["#{field} = ?", [value]]
            end
          end

          def order(order_conditions)
            order_conditions.parts.each do |part|
              if part.is_a? RademadeAdmin::Search::Part::Order
                # todo
              else
                @result = @result.order_append(::Sequel.send(part[:value], part[:field].to_sym))
              end
            end
            @result
          end

          def paginate(page_condition, per_page_condition)
            @result.paginate(page_condition, per_page_condition)
          end

        end
      end
    end
  end
end
