# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query
        class PostgresqlQuery < RademadeAdmin::Model::Adapter::Query::ActiveRecordQuery

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
        end
      end
    end
  end
end
