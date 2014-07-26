# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Configuration
      class Fields

        def find(name)
          name = name.to_sym
          field = @fields.select{|field| field.name == name}.first
          puts field
          return nil if field.nil?
          yield( field ) if block_given?
          field
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
          #todo custom exception
          raise 'Field class for {CLASS} fields not defined'
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
