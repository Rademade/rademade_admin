# -*- encoding : utf-8 -*-
require 'search/conditions/abstract'

module RademadeAdmin
  module Search
    module Conditions
      class List < Abstract

        protected

        def where
          where_conditions = Where.new(:and)
          @params.slice(*@origin_fields).each do |field, value|
            where_conditions.add(field, value)
          end
          where_conditions
        end

        def order
          field = @params[:sort] || default_order_field
          direction = @params[:direction] || :asc
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
          @origin_fields.include?('position') ? :position : :id
        end

      end
    end
  end
end
