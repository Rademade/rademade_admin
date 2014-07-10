module RademadeAdmin
  module Search
    class AutocompleteConditions < Abstract

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
        unless @params[:q].present?
          @filter_fields.each do |field|
            @where_conditions[:or][field] = /#{@params[:q]}/i
          end
        end
      end

      def append_search_params
        if @params[:search].present?
          @params[:search].each do |key, value|
            @where_conditions[:and][key.to_sym] = value if @origin_fields.include? key.to_s
          end
        end
      end

    end
  end
end