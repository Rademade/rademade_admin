module RademadeAdmin
  module Model
    class Reflection
      module Data

        def association_fields
          relations.keys.map &:to_sym
        end

        def data_adapter
          @data_adapter ||= init_data_adapter
        end

        def method_missing(name, *arguments)
          if data_adapter.respond_to? name
            data_adapter.send(name, *arguments)
          end
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