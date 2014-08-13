# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class Fields

        def find(name)
          name = name.to_sym
          field = @fields.select { |field| field.name == name }.first
          return nil if field.nil?
          yield(field) if block_given?
          field
        end

        def find_with_index(name)
          name = name.to_sym
          found_field, found_index = nil, nil
          @fields.each_with_index do |field, index|
            if field.name == name
              found_field, found_index = field, index
              break
            end
          end
          return nil if found_field.nil?
          yield(found_field, found_index) if block_given?
          { :field => found_field, :index => found_index }
        end

        def all
          @fields
        end

        def method_missing(name, *arguments)
          @fields << field_class.new(name.to_sym, *arguments)
        end

        def configure(*options, &block)
          block_given? ? instance_eval(&block) : _init_from_options(*options)
        end

        protected

        def initialize
          @fields = []
        end

        def field_class
          raise NotImplementedError, 'Field class for {CLASS} fields not defined'
        end

        def _init_from_options(*options)
          options.each do |option|
            #todo add validation
            @fields << field_class.new(option.to_sym)
          end
        end

      end
    end
  end
end
