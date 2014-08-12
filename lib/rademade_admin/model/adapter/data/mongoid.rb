# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data

        #
        # Data adapter for Mongoid
        #
        class Mongoid < RademadeAdmin::Model::Adapter::Data

          protected

          def has_many_relations
            [:embeds_many, :has_many, :has_and_belongs_to_many]
          end

          def has_one_relations
            [:has_one, :embeds_one, :belongs_to]
          end

          def _map_relations
            relations = {}
            @model.relations.each do |name, relation_info|
              name = name.to_sym
              type = relation_info.relation.macro

              has_many = has_many_relations.include?(type)
              id_getter = has_many ? "#{name.to_s.singularize}_ids" : "#{name}_id"
              relations[name] = ::RademadeAdmin::Model::Info::Relation.new({
                :name => name,
                :from => @model.class,
                :to => RademadeAdmin::LoaderService.const_get(relation_info.class_name),
                :getter => name.to_s,

                #rm_todo нужно этих ребят убрать. Такая связь должна подерживатся на уровне DataItem(field, relation)
                :id_getter => id_getter,
                :id_setter => id_getter + '=',

                :setter => relation_info.setter,
                :type => type,
                :has_many => has_many
              })
            end
            relations
          end

          def _map_fields
            fields = {}
            @model.fields.each do |name, field_data|
              name = name.to_sym
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => name == :_id,
                :foreign_key => field_data.foreign_key?,
                :setter => name.to_s + '=',
                :getter => name.to_s,
                :type => field_data.type,
                :relation_name => field_data.metadata.nil? ? nil : field_data.metadata.name
              })
            end
            fields
          end

        end

      end
    end
  end
end
