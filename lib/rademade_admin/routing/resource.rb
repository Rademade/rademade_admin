# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Routing
    class Resource < ActionDispatch::Routing::Mapper::Resources::Resource
      def default_actions
        super + [:autocomplete]
      end
    end
  end
end
