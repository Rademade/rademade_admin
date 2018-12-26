module RademadeAdmin
  class RoutingResource < ActionDispatch::Routing::Mapper::Resources::Resource

    def default_actions
      super + [:autocomplete]
    end

  end
end