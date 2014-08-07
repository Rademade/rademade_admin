module Kaminari
  module Helpers
    class Tag
      def page_url_for(page)
        admin_params = @params.extract!(:admin_params)
        params = @params.merge(@param_name => (page <= 1 ? nil : page), :only_path => true)
        if admin_params.empty?
          @template.url_for params
        else
          symbolized_params = params.inject({}){|memo,(k,v)| memo[k.to_sym] = v; memo}
          Rails.application.routes.url_for(symbolized_params)
        end
      end
    end
  end
end