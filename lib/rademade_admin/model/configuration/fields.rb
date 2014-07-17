# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Fields

      attr_reader :fields

      def self.init_from_block(&block)
        model_fields = self.new
        model_fields.instance_eval(&block)
        model_fields
      end

      def self.init_from_options(field_options)
        model_fields = self.new(field_options)
        model_fields
      end

      def initialize(fields = [])
        @fields = fields
      end

      def method_missing(name, *arguments)
        if arguments.empty?
          field = name.to_sym
        else
          field = { name.to_sym => arguments.first }
        end
        @fields << field
      end

    end
  end
end
