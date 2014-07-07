module RademadeAdmin
  module Search
    class ListConditions < Conditions

      protected

      def where
        where_conditions = super
        where_conditions[:and] = @params.slice(*@origin_fields)
        where_conditions
      end

      def order
        field = @params[:sort] || :position
        direction = @params[:direction] || :asc
        [{field => direction}]
      end

      def page
        @params[:page] || 1
      end

      def per_page
        @params[:paginate] || 20
      end

    end
  end
end