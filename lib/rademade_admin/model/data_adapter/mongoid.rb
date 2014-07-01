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

        def has_many
          @has_many_relations ||= relations_with_types HAS_MANY_RELATIONS
        end

        def has_one
          @has_one_relations ||= relations_with_types HAS_ONE_RELATIONS
        end

        def fields
          @model.fields
        end

        private

        def relations_with_types(types)
          @model.reflect_on_all_associations(*types).map do |relation|
            relation[:class_name] || relation[:name].to_s.capitalize
          end
        end

      end
    end
  end
end