# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data

        # Data adapter for mongoid
        #
        class Mongoid < RademadeAdmin::Model::Adapter::Data

          def relations
            @relations ||= _map_relations
          end

          def relations_exist?(name)
            @relations.has_key? name.to_sym
          end

          def relation(name)
            relations[name.to_sym]
          end

          def many_relation?(field)
            relation( field.to_sym ).try(:many?)
          end

          def fields
            #todo map to field class
            @model.fields
          end

          def has_field?(field)
            fields.keys.include? field
          end

          def foreign_key?(field)
            field.foreign_key?
          end

          protected

          def has_many_relations
            [:embeds_many, :has_many, :has_and_belongs_to_many]
          end

          def has_one_relations
            [:has_one, :embeds_one, :belongs_to]
          end

          def _map_relations
            relations = {}
            @model.relations.each do |data|
              name = data.first
              relation = data.last
              relations[name] = RademadeAdmin::Model::Info::Relation.new({
                :name => name,
                :from => @model.class,
                :to => RademadeAdmin::LoaderService.const_get(relation.class_name),
                :setter => relation.setter,
                :has_many => relation.try(:many?)
              })
            end
            relations
          end

        end

      end
    end
  end
end
