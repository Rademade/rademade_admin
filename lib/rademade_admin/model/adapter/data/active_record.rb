# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data

        # Data adapter for active_record
        #
        class ActiveRecord < RademadeAdmin::Model::Adapter::Data

          def relations
            @model.reflections
          end

          def reflect_on_association(name)
            @model.reflect_on_association(name)
          end

          def many_relation?(field)
            reflect_on_association(field).try(:collection?)
          end

          def association_foreign_key(relation)
            assoc_key = relation.name.to_s
            if relation.collection?
              assoc_key.singularize.foreign_key.pluralize
            else
              assoc_key.foreign_key
            end
          end

          def fields
            #todo map to field class
            @model.column_types
          end

          def foreign_key?(field)
            if field.is_a? ::ActiveRecord::AttributeMethods::TimeZoneConversion::Type # why another behaviour?
              field_name = field.instance_values['column'].name
            else
              field_name = field.name
            end
            field_name[-3, 3] == '_id'
          end

          protected

          def has_many_relations
            [:has_many, :has_and_belongs_to_many]
          end

          def has_one_relations
            [:has_one, :belongs_to]
          end

        end

      end
    end
  end
end
