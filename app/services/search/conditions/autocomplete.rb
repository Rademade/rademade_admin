module RademadeAdmin
  module Search
    class AutocompleteConditions < Conditions

      def initialize(params, origin_fields, filter_fields)
        super(params, origin_fields)
        @filter_fields = filter_fields
      end

      protected

      def where
        # todo hierarchical
        @where_conditions = super
        append_query_condition
        append_search_params
        @where_conditions
      end

      def limit
        10
      end

      private

      def append_query_condition
        query = @params[:q]
        unless query.empty?
          @filter_fields.each do |field|
            @where_conditions[:or][field] = /#{query}/i
          end
        end
      end

      def append_search_params
        if @params[:search].present?
          @params[:search].each do |key, value|
            field = key.to_s
            if origin_fields.include? field
              field_value = key.to_s.include?('_in') ? Array.wrap(value) : value
              @where_conditions[:and][field.to_sym] = field_value
            end
          end
        end
      end

    end
  end
end