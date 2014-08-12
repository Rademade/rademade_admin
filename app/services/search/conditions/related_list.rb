# -*- encoding : utf-8 -*-
require 'search/conditions/abstract'

module RademadeAdmin
  module Search
    module Conditions
      class RelatedList < Abstract

        attr_reader :item

        def base_condition(model)
          @item.send(@params[:relation])
        end

        protected

        def initialize(item, params, origin_fields)
          @item = item
          super(params, origin_fields)
        end

        def where
          where_conditions = RademadeAdmin::Search::Part::Where.new(:and)
          @params.slice(*@fields.origin_fields).each do |field, value|
            where_conditions.add(field, value)
          end
          where_conditions
        end

        def order
          field = @params[:sort] || default_order_field
          [{field => direction}]
        end

        def page
          @params[:page] || 1
        end

        def per_page
          @params[:paginate] || 20
        end

        private

        def default_order_field
          @fields.origin_fields.include?('position') ? :position : :id
        end

        def direction
          if @params[:direction].present?
            @params[:direction].to_sym
          else
            :asc
          end
        end

      end
    end
  end
end
