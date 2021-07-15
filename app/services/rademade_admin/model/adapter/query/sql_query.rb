# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query
        class SqlQuery < RademadeAdmin::Model::Adapter::Query

          protected

          def where(where_conditions)
            condition, values = collect_where_conditions(where_conditions)
            values.empty? ? @result : @result.where([condition, *values])
          end

          def collect_where_conditions(where_conditions)
            condition = ''
            values = []
            where_conditions.parts.each do |part|
              condition += " #{where_conditions.type.to_s.capitalize} " unless condition.empty?
              if part.is_a? RademadeAdmin::Search::Part::Where
                where_condition, value = collect_where_conditions(part)
                condition += "(#{where_condition})"
              else
                where_condition, value = build_where_condition(part)
                condition += where_condition
              end
              values += value
            end
            [condition, values]
          end

          def build_where_condition(field: nil, value: nil)
            field = table_field(field)
            if value.is_a? Regexp
              ["LOWER(#{field}) REGEXP LOWER(?)", [value.source]]
            elsif value.is_a? Array
              ["#{field} IN (?)", [value]]
            else
              ["#{field} = ?", [value]]
            end
          end

          def table_field(field)
            "#{@model.table_name}.#{field}"
          end
        end
      end
    end
  end
end
