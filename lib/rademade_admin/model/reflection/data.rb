module RademadeAdmin
  module Model
    class Reflection
      module Data

        def relations
          data_adapter.relations
        end

        def reflect_on_association(name)
          data_adapter.reflect_on_association(name)
        end

        def has_many
          data_adapter.has_many
        end

        def has_one
          data_adapter.has_one
        end

        def fields
          data_adapter.fields
        end

        def has_field?(field)
          fields.keys.include? field
        end

        def association_fields
          relations.keys.map &:to_sym
        end

        def data_adapter
          @data_adapter ||= init_data_adapter
        end

        private

        def init_data_adapter
          adapter_map = {
            'ActiveRecord::Base' => 'ActiveRecord',
            'Mongoid::Document' => 'Mongoid'
          }
          adapter_map.each do |ar_class, adapter_class|
            if @model.ancestors.include? ar_class.constantize
              return "RademadeAdmin::Model::DataAdapter::#{adapter_class}".constantize.new(@model)
            end
          end
          nil
        end

      end
    end
  end
end