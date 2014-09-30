module ActiveRecord

  module Associations
    module Builder
      class Association

        alias_method :original_valid_options, :valid_options

        def valid_options
          original_valid_options + [:sortable, :sortable_field]
        end

      end
    end
  end

  module Reflection
    class AssociationReflection

      def sortable_field
        @options.fetch(:sortable_field, :position)
      end

      def sortable?
        @options.fetch(:sortable, false)
      end

    end
  end

  module Associations
    class HasManyAssociation

      alias_method :original_reader, :reader
      alias_method :original_writer, :writer

      def reader(force_reload = false)
        result = original_reader(force_reload)
        # todo do not order if it was ordered
        if reflection.sortable?
          result = result.order("#{(try(:through_reflection) || reflection).table_name}.#{reflection.sortable_field} ASC")
        end
        result
      end

      def writer(records)
        original_writer(records)
        sort_entities(records)
      end

      private

      def sort_entities(records)
        if respond_to? :through_reflection
          if through_reflection.sortable?
            record_positions = {}
            records.each_with_index do |record, index|
              record_positions[record.id] = index + 1
            end

            intermediate_entities = owner.send(through_reflection.name)
            intermediate_entities.each do |intermediate_entity|
              new_position = record_positions[intermediate_entity.send(source_reflection.foreign_key)]
              intermediate_entity.send(:"#{reflection.sortable_field}=", new_position)
              intermediate_entity.save
            end
          end
        else
          if reflection.sortable?
            records.each_with_index do |record, index|
              record.send(:"#{reflection.sortable_field}=", index + 1)
              record.save
            end
          end
        end
      end

    end
  end

end