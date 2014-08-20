# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Search
    class Searcher

      #
      # @param model_info [RademadeAdmin::Model::Info]
      #
      def initialize(model_info)
        @model_info = model_info
      end

      #
      # @param search_conditions [RademadeAdmin::Search::Conditions::Abstract]
      #
      def search(search_conditions)
        @model_info.query_adapter.exec_query(search_conditions)
      end

    end
  end
end
