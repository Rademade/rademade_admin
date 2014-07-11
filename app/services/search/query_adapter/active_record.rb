require 'search/query_adapter/abstract'

module RademadeAdmin
  module Search
    module QueryAdapter
      class ActiveRecord < Abstract

        protected

        def where(where_conditions)
          @values = []
          condition = collect_where_conditions(where_conditions)
          @result.where([condition, *@values])
        end

        def order(order_conditions)
          order_conditions.each do |order_condition|
            @result = @result.order(order_condition)
          end
          @result
        end

        def collect_where_conditions(where_conditions)
          condition = ''
          where_conditions.parts.each do |part|
            condition += " #{where_conditions.type.to_s.capitalize} " unless condition.empty?
            if part.is_a? RademadeAdmin::Search::Conditions::Where
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