module RademadeAdmin
  module Model
    module DataAdapter
      class Mongoid
        include RademadeAdmin::Model::DataAdapter

        def relations
          @model.relations
        end

        def reflect_on_association(name)
          @model.reflect_on_association(name)
        end

        def association_foreign_key(relation)
          rel_name = relation.name.to_s
          if relation.many?
            rel_name.singularize.foreign_key + 's'
          else
            rel_name.foreign_key
          end
        end

        def fields
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

      end
    end
  end
end