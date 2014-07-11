module RademadeAdmin
  module Model
    module DataAdapter
      class ActiveRecord
        include RademadeAdmin::Model::DataAdapter

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
          assoc_key = relation.association_foreign_key
          if relation.collection?
            assoc_key += 's'
          end
          assoc_key
        end

        def fields
          @model.column_types
        end

        def has_field?(field)
          fields.include? field
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