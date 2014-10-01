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

          def _map_fields
            fields = {}
            @model.fields.each do |name, field_data|
              name = name.to_sym
              getter = name.to_s
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => name == :_id,
                :getter => getter,
                :setter => getter + '=',
                :type => field_data.type,
                :is_date_time => field_data.type == DateTime,
                :localizable => field_data.localized?,
                :relation_name => field_data.options[:metadata].try(:name)
              })
            end
            fields
          end

          def _map_relations
            relations = {}
            @model.relations.each do |name, relation_info|
              name = name.to_sym
              type = relation_info.relation.macro
              is_sortable = relation_info.sortable?
              relations[name] = ::RademadeAdmin::Model::Info::Relation.new({
                :name => name,
                :from => @model,
                :to => to_class(relation_info),
                :getter => name.to_s,
                :setter => relation_info.setter,
                :type => type,
                :many => type == :has_many,
                :has_many => has_many_relations.include?(type),
                :sortable => is_sortable,
                :sortable_field => is_sortable ? relation_info.sortable_field : nil,
                :foreign_key => relation_info.foreign_key.to_sym
              })
            end
            relations
          end

          private

          def to_class(relation_info)
            RademadeAdmin::LoaderService.const_get(relation_info.class_name)
          rescue
            nil
          end

        end

      end
    end
  end
end
