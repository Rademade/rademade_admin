module RademadeAdmin::CrudController::Search
  class Searcher
    class SearchConditions
      DEFAULTS = { sort_by:    'position',
                   direction:  'asc',
                   pagination: '20' }.freeze

      def order
        sort      = @params[:sort] || DEFAULTS[:sort_by] # DnD sort by default
        direction = (@params[:direction] || DEFAULTS[:direction]).capitalize

        @order ||= "#{sort} #{direction}"
      end

      def where
        filtered = @params.slice( *@origin_fields )
        filtered[:deleted_at] = nil if @paranoia

        @where = filtered
      end

      def per_page
        @per_page ||= (@params[:paginate] || DEFAULTS[:pagination])
      end

      def page
        @page ||= @params[:page]
      end

      def initialize(params, origin_fields, paranoia=false)
        @paranoia = paranoia
        @origin_fields = origin_fields
        @params = params
      end

    end
  end
end