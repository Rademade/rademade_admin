# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Search
    class Related

      attr_accessor :item, :model_info, :relation

      def initialize(item, model_info, relation_name)
        @item, @model_info = item, model_info
        if model_info.relation_exist? relation_name
          @relation = model_info.relation relation_name
        else
          raise Rademade::Exceptions::WrongRelation
        end
      end

      def find( params)
        if relation.has_one?
          @item.send( relation.name )
        elsif relation.has_many?
           #conditions = Search::Conditions::RelatedList.new(@item, params, origin_fields)
           #@items = Search::Searcher.new(model_info).search( conditions )
        else
          #exction
        end
      end

      def add(id)
        #todo
      end

      def remove(id)
        #todo
      end

    end
  end
end
