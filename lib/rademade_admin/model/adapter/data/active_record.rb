# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data

        # Data adapter for active_record
        #
        class ActiveRecord < RademadeAdmin::Model::Adapter::Data

          protected

          def has_many_relations
            [:has_many, :has_and_belongs_to_many]
          end

          def has_one_relations
            [:has_one, :belongs_to]
          end

          def _map_fields
            fields = {}
            @model.column_types.each do |name, field_data|
              name = name.to_sym
              column_data = extract_column_data(field_data)
              getter = name.to_s
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => column_data.primary,
                :getter => getter,
                :setter => getter + '=',
                :type => column_data.type
              })
            end
            fields
          end

          def _map_relations
            relations = {}
            @model.reflections.each do |name, relation_info|
              name = name.to_sym
              getter = name.to_s
              type = relation_info.macro
              relations[name] = ::RademadeAdmin::Model::Info::Relation.new({
                :name => name,
                :from => @model,
                :to => RademadeAdmin::LoaderService.const_get(relation_info.class_name),
                :getter => getter,
                :setter => getter + '=',
                :type => type,
                :has_many => has_many_relations.include?(type),
                :foreign_key => relation_info.foreign_key
              })
            end
            relations
          end

          private

          def extract_column_data(field_data)
            if field_data.is_a? ::ActiveRecord::AttributeMethods::TimeZoneConversion::Type # why another behaviour?
              field_data.instance_values['column']
            else
              field_data
            end
          end

        end

      end
    end
  end
end
