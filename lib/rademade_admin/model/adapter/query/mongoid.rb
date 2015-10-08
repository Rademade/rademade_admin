# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query
        class Mongoid < RademadeAdmin::Model::Adapter::Query

          def find(ids)
            @model.find(ids)
          end

          def initial
            @model.unscoped
          end

          protected

          WHERE_METHOD_MAP = { :or => :or, :and => :where }.freeze

          def where(where_conditions)
            if defined?(::Mongoid::Paranoia) and @model.ancestors.include? ::Mongoid::Paranoia
              where_condition = RademadeAdmin::Search::Part::Where.new(:and)
              where_condition.add(:deleted_at, nil)
              where_condition.sub_add(where_conditions) if where_conditions
              where_conditions = where_condition
            end
            collect_where_condition(where_conditions, @result)
          end

          def order(order_conditions)
            order_conditions.parts.each do |part|
              if part.is_a? RademadeAdmin::Search::Part::Order
                # todo
              else
                @result = @result.order_by(part[:field] => part[:value])
              end
            end
            @result
          end

          def paginate(page_condition, per_page_condition)
            @result.page(page_condition).per(per_page_condition)
          end

          def collect_where_condition(where_conditions, result)
            where_method = WHERE_METHOD_MAP[where_conditions.type]
            where_conditions.parts.each do |part|
              if part.is_a? RademadeAdmin::Search::Part::Where
                result = result.send(where_method, where_sub_condition(part))
              else
                field = part[:field]
                field = field.in if part[:value].is_a? Array
                result = result.send(where_method, field => part[:value])
              end
            end
            result
          end

          def where_sub_condition(where_sub_conditions)
            collect_where_condition(where_sub_conditions, @model.all).selector
          end

        end
      end
    end
  end
end
