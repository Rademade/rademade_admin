module RademadeAdmin
  module Model
    class Labels

      attr_reader :labels

      def initialize
        @labels = {}
      end

      def init_from_block(&block)
        instance_eval(&block)
      end

      def label_for(field)
        if @labels[field].present?
          @labels[field]
        else
          field.to_s.humanize
        end
      end

      def method_missing(name, *arguments)
        @labels[name.to_sym] = arguments.first
      end

    end
  end
end