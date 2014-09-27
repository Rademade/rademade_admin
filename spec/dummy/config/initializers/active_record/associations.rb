module ActiveRecord

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
    class HasManyThroughAssociation

      alias_method :original_reader, :reader
      alias_method :original_writer, :writer

      def reader(force_reload = false)
        result = original_reader(force_reload)
        # todo do not order if it was ordered
        if association_reflection.sortable?
          result = result.order("#{options[:through]}.#{association_reflection.sortable_field} ASC")
        end
        result
      end

      def writer(records)
        if association_reflection.sortable?
          intermediate_records = through_reflection.klass
            .where(through_reflection.foreign_key.to_sym => owner.id)
            .where(source_reflection.foreign_key.to_sym => records.map(&:id))
          intermediate_records.each_with_index do |intermediate_record, index|
            intermediate_record.send(:"#{association_reflection.sortable_field}=", index + 1)
            intermediate_record.save
          end
        end
        original_writer(records)
      end

      ## Implements the ids reader method, e.g. foo.item_ids for Foo.has_many :items
      #def ids_reader
      #  if loaded?
      #    load_target.map do |record|
      #      record.send(reflection.association_primary_key)
      #    end
      #  else
      #    column  = "#{reflection.quoted_table_name}.#{reflection.association_primary_key}"
      #    scope.pluck(column)
      #  end
      #end
      #
      ## Implements the ids writer method, e.g. foo.item_ids= for Foo.has_many :items
      #def ids_writer(ids)
      #  pk_column = reflection.primary_key_column
      #  ids = Array(ids).reject { |id| id.blank? }
      #  ids.map! { |i| pk_column.type_cast(i) }
      #  replace(klass.find(ids).index_by { |r| r.id }.values_at(*ids))
      #end

      private

      def association_reflection
        through_reflection.parent_reflection.last
      end

    end
  end

end