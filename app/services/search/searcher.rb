module RademadeAdmin
  module Search
    class Searcher

      def initialize(model_info)
        @model_info = model_info
      end

      def search(search_conditions, is_related_list = false)
        query_adapter.apply_conditions(search_conditions, is_related_list)
      end

      def query_adapter
        @query_adapter ||= "RademadeAdmin::Search::#{@model_info.model_reflection.orm_type}".constantize.new(@model_info.model)
      end

    end
  end
end