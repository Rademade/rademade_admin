module RademadeAdmin
  module Model
    module DataAdapter

      def initialize(model)
        @model = model
      end

      def relations
        []
      end

      def reflect_on_association(name)
        nil
      end

      def has_many
        []
      end

      def has_one
        nil
      end

      def fields
        []
      end

    end
  end
end