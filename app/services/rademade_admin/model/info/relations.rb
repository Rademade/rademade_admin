# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info
      class Relations

        #@param data_adapter [RademadeAdmin::Model::Adapter::Data]
        #
        def initialize(data_adapter)
          @data_adapter = data_adapter
        end

        # Return array of RademadeAdmin::Model::Info::Relation
        #
        # @return [Array]
        #
        def all
          @data_adapter.relations
        end

        # Return status of relation availability
        #
        # @param name [String]
        # @return [Bool]
        #
        def exist?(name)
          @data_adapter.has_relation? name
        end

        # @param name [String]
        # @return [RademadeAdmin::Model::Info::Relation]
        #
        def relation(name)
          @data_adapter.relation name
        end

      end
    end
  end
end