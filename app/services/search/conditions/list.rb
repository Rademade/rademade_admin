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
          order_conditions = super
          order_conditions.unshift(order_field, @params[:direction])
          order_conditions
        end

        def page
          @params[:page] || 1
        end

        def per_page
          @params[:paginate] || 20
        end

        private

        def order_field
          if @params[:sort] && @data_items.data_item(@params[:sort]).column?
            @params[:sort]
          else
            @data_items.has_field?(:position) ? :position : :id
          end
        end

      end
    end
  end
end