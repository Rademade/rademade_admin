module RademadeAdmin
  module Model
    class Reflection
      include Uploader
      include Data

      attr_reader :model, :controller

      def initialize(model, controller, controller_name, inner)
        @model, @controller, @controller_name, @inner = model, controller, controller_name, inner
      end

      def nested?
        @inner
      end

    end
  end
end