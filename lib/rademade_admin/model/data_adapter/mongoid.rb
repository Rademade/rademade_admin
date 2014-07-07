module RademadeAdmin
  module Model
    module DataAdapter
      class Mongoid
        include RademadeAdmin::Model::DataAdapter

        HAS_MANY_RELATIONS = [:embeds_many, :has_many, :has_and_belongs_to_many].freeze
        HAS_ONE_RELATIONS = [:has_one, :embeds_one, :belongs_to].freeze

        def relations
          @model.relations
        end

        def reflect_on_association(name)
          @model.reflect_on_association(name)
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

      end
    end
  end
end