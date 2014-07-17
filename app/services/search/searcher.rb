# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Search
    class Searcher

      def initialize(model_info)
        @model_info = model_info
      end

      def search(search_conditions)
        query_adapter.apply_conditions(search_conditions)
      end

      def query_adapter
        @query_adapter ||= "RademadeAdmin::Search::QueryAdapter::#{@model_info.model_reflection.orm_type}".constantize.new(@model_info.model)
      end

    end
  end
end
