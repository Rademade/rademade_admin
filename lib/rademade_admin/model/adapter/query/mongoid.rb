# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Query

        class Mongoid < RademadeAdmin::Model::Adapter::Query

          protected

          WHERE_METHOD_MAP = { :or => :or, :and => :where }.freeze

          def where(where_conditions)
            if defined?(::Mongoid::Paranoia) and @model.ancestors.include? ::Mongoid::Paranoia
              where_condition = RademadeAdmin::Search::Conditions::Where.new(:and)
              where_condition.add(:deleted_at, nil)
              where_condition.sub_add(where_conditions) if where_conditions
              where_conditions = where_condition
            end
            collect_where_condition(where_conditions, @result)
          end

          def order(order_conditions)
            order_conditions.each do |order_condition|
              @result = @result.order_by(order_condition)
            end
            @result
          end

          def collect_where_condition(where_conditions, result)
            where_method = WHERE_METHOD_MAP[where_conditions.type]
            where_conditions.parts.each do |part|
              if part.is_a? RademadeAdmin::Search::Conditions::Where
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
