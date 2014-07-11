require 'search/conditions/abstract'

module RademadeAdmin
  module Search
    module Conditions
      class RelatedList < Abstract

        def base_condition(model)
          model_related_name = model.to_s.demodulize.pluralize.downcase.to_sym
          @params[:parent].constantize.find(@params[:parent_id]).send(model_related_name)
        end

        protected

        def where
          where_conditions = super
          where_conditions[:and] = @params.slice(*@origin_fields)
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