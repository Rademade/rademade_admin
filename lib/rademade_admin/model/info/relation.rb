# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Relation

        attr_reader :name, :from, :to, :getter, :setter, :type, :foreign_key, :sortable_field

        def has_many?
          @has_many
        end

        def many?
          @many
        end

        def sortable?
          @sortable
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
          @many = opt[:many]
          @foreign_key = opt[:foreign_key]
          @sortable = opt[:sortable]
          @sortable_field = opt[:sortable_field]
        end

      end
    end
  end
end