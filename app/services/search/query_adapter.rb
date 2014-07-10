module RademadeAdmin
  module Search
    class QueryAdapter

      def initialize(model)
        @model = model
      end

      def apply_conditions(search_conditions, is_related_list)
        # todo something with is_related_list
        @params = search_conditions.params
        @result = is_related_list ? related_base_condition : base_condition
        search_conditions.conditions.each do |query_part, values|
          @result = self.send(query_part, values) unless values.nil?
        end
        @result
      end

      protected

      def base_condition
        @model.unscoped
      end

      def related_base_condition
        parent_model = @params[:parent].constantize
        parent_id = @params[:parent_id]
        model_related_name = @model.to_s.demodulize.pluralize.downcase.to_sym
        parent_model.find(parent_id).send(model_related_name).unscoped
      end

      def where(where_conditions)
        @result
      end

      def order(order_conditions)
        @result
      end

      def page(page_condition)
        @result.page(page_condition)
      end

      def per_page(per_page_condition)
        @result.per(per_page_condition)
      end

      def limit(limit_condition)
        @result.limit(limit_condition)
      end

    end
  end
end