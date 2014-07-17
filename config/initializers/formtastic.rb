module Formtastic
  module Helpers
    module InputHelper

      def input_class(as)
        @input_classes_cache ||= {}
        @input_classes_cache[as] ||= input_class_by_trying(as)
      end

    end
  end
end