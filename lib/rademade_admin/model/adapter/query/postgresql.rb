# -*- encoding : utf-8 -*-
require 'rademade_admin/model/adapter/query/active_record'

module RademadeAdmin
  module Model
    module Adapter
      class Query
        class Postgresql < RademadeAdmin::Model::Adapter::Query::ActiveRecord

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
