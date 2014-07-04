module RademadeAdmin
  module Model
    module DataAdapter
      class ActiveRecord
        include RademadeAdmin::Model::DataAdapter

        HAS_MANY_RELATIONS = [:has_many, :has_and_belongs_to_many].freeze
        HAS_ONE_RELATIONS = [:has_one, :belongs_to].freeze

        def relations
          @model.reflections
        end

        def reflect_on_association(name)
          @model.reflect_on_association(name)
        end

        def fields
          @model.column_types
        end

        def has_field?(field)
          fields.include? field
        end

      end
    end
  end
end