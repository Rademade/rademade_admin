# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query

        class ActiveRecord < RademadeAdmin::Model::Adapter::Query

          protected

          def where(where_conditions)
            @values = []
            condition = collect_where_conditions(where_conditions)
            @result.where([condition, *@values])
          end

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

          def collect_where_conditions(where_conditions)
            condition = ''
            where_conditions.parts.each do |part|
              condition += " #{where_conditions.type.to_s.capitalize} " unless condition.empty?
              if part.is_a? RademadeAdmin::Search::Part::Where
                condition += "(#{collect_where_conditions(part)})"
              else
                if part[:value].is_a? Array
                  condition += "#{part[:field]} IN (?)"
                else
                  condition += "#{part[:field]} = ?"
                end
                @values << part[:value]
              end
            end
            condition
          end

        end
      end
    end
  end
end
