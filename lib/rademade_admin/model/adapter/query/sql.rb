# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query
        class Sql < RademadeAdmin::Model::Adapter::Query

          protected

          def where(where_conditions)
            @values = []
            condition = collect_where_conditions(where_conditions)
            @values.empty? ? @result : @result.where([condition, *@values])
          end

          def collect_where_conditions(where_conditions)
            condition = ''
            where_conditions.parts.each do |part|
              condition += " #{where_conditions.type.to_s.capitalize} " unless condition.empty?
              if part.is_a? RademadeAdmin::Search::Part::Where
                condition += "(#{collect_where_conditions(part)})"
              else
                field = "`#{part[:field]}`"
                if part[:value].is_a? Regexp
                  # hack temporary fix
                  condition += "LOWER(#{field}) REGEXP ?"
                  part[:value] = part[:value].source
                elsif part[:value].is_a? Array
                  condition += "#{field} IN (?)"
                else
                  condition += "#{field} = ?"
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