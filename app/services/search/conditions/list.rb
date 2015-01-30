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
          list_order_field = order_field
          order_conditions.unshift(list_order_field, @params[:direction]) unless list_order_field.nil?
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
          if @params[:sort]
            @params[:sort]
          else
            @data_items.has_field?(:position) ? :position : nil
          end
        end

      end
    end
  end
end