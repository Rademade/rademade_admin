module RademadeAdmin
  module Model
    module DataAdapter

      HAS_MANY_RELATIONS = []
      HAS_ONE_RELATIONS = []

      def initialize(model)
        @model = model
      end

      def relations
        @model.relations
      end

      def reflect_on_association(name)
        nil
      end

      def fields
        []
      end

      def has_field?(field)
        false
      end

      def foreign_key?(field)
        false
      end

      def has_many
        @has_many_relations ||= relations_with_types HAS_MANY_RELATIONS
      end

      def has_one
        @has_one_relations ||= relations_with_types HAS_ONE_RELATIONS
      end

      protected

      def relations_with_types(types)
        @model.reflect_on_all_associations(*types).map do |relation|
          relation[:class_name] || relation[:name].to_s.capitalize
        end
      end

    end
  end
end