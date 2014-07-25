module RademadeAdmin
  module Model
    class Configuration
      class Labels

        attr_reader :labels

        def initialize
          @labels = {}
        end

        def init_from_block(&block)
          instance_eval(&block)
        end

        def method_missing(name, *arguments)
          @labels[name.to_sym] = arguments.first
        end

      end
    end
  end
end