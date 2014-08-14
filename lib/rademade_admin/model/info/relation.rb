# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Relation

        attr_reader :name, :from, :to, :getter, :setter, :type, :foreign_key

        def many?
          @has_many
        end

        def related_entities(ids)
          RademadeAdmin::Model::Graph.instance.model_info(to).query_adapter.find(ids)
        end

        protected

        # Initialization for Relation info
        #
        # Required options in Hash :name, :from, :to, :setter, :has_many
        # @param opt [Hash]
        #
        def initialize(opt = {})
          @name = opt[:name]
          @from = opt[:from]
          @to = opt[:to]
          @getter = opt[:getter]
          @setter = opt[:setter]
          @type = opt[:type]
          @has_many = opt[:has_many]
          @foreign_key = opt[:foreign_key]
        end

      end
    end
  end
end