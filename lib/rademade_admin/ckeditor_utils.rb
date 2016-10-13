module Ckeditor
  module Utils
    class << self
      def js_replace(dom_id, options = nil)
        js = ["(function() { if (typeof CKEDITOR != 'undefined') {"]

        if options && !options.keys.empty?
          js_options = ActiveSupport::JSON.encode(options)
          js << "CKEDITOR.replace('#{dom_id}', #{js_options}); }"
        else
          js << "CKEDITOR.replace('#{dom_id}'); }"
        end

        js << '})();'
        js.join.html_safe
      end
    end
  end
end
