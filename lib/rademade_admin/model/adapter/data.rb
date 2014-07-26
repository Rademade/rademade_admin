# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data

        #
        # Initialization method
        #
        def initialize(model)
          @model = model
        end

        #
        # Return array of RademadeAdmin::Model::Info::Relation
        #
        # @return [Array]
        #
        def relations
          @relations ||= _map_relations
        end

        #
        # @return [Bool]
        #
        def has_relation?(name)
          not relation(name).nil?
        end

        #
        #
        # @return [RademadeAdmin::Model::Info::Relation]
        #
        def relation(name)
          relations[name.to_sym]
        end

        #
        # Returns array of relations keys
        #
        # @return [Array]
        #
        def association_fields
          relations.keys.map &:to_sym
        end

        #
        # Returns array of fields with class [RademadeAdmin::Model::Info::Field]
        #
        # @return [Array]
        #
        def fields
          @fields ||= _map_fields
        end

        #
        # @return [Bool]
        #
        def has_field?(name)
          field(name).nil?
        end

        #
        # @return [RademadeAdmin::Model::Info::Field]
        #
        def field(name)
          fields[name.to_sym]
        end

        #
        # @return [Array]
        #
        def has_many
          @has_many_relations ||= relations.filter{|rel| has_many_relations.include?(rel.type) }
        end

        #
        # @return [Array]
        #
        def has_one
          @has_one_relations ||= relations.filter{|rel| has_one_relations.include?(rel.type) }
        end

        protected

        def has_many_relations
          []
        end

        def has_one_relations
          []
        end

        def _map_relations
          #todo custom error
          raise 'Not defined _map_relations for class'
        end

        def _map_fields
          #todo custom error
          raise 'Not defined _map_fields for class'
        end

      end
    end
  end
end
