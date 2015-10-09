# -*- encoding : utf-8 -*-
require 'rademade_admin/model/adapter/query/sql'

module RademadeAdmin
  module Model
    module Adapter
      class Query
        class Sequel < RademadeAdmin::Model::Adapter::Query::Sql

          def find(ids)
            @model[ids]
          end

          def initial
            @model.dataset
          end

          protected

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