module SimpleForm
  module Components
    module Errors

      def errors_on_attribute
        object.errors[attribute_name] || []
      end

      def full_errors_on_attribute
        object.errors.full_messages_for(attribute_name) || []
      end

    end
  end
end