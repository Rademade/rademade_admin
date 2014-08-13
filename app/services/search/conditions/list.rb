# -*- encoding : utf-8 -*-
require 'search/conditions/abstract'

module RademadeAdmin
  module Search
    module Conditions
      class List < Abstract

        protected

        def where
          where_conditions = RademadeAdmin::Search::Part::Where.new(:and)
          @params.slice(*@data_items.origin_fields).each do |field, value|
            where_conditions.add(field, value)
          end
          where_conditions
        end

        def order
          order_conditions = RademadeAdmin::Search::Part::Order.new
          field = @params[:sort] || default_order_field
          order_conditions.add(field, @params[:direction])
          order_conditions
        end

        def page
          @params[:page] || 1
        end

        def per_page
          @params[:paginate] || 20
        end

        private

        def default_order_field
          @data_items.origin_fields.include?('position') ? :position : :id
        end

      end
    end
  end
end
