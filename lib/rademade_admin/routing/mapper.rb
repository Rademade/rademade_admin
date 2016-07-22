# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Routing
    module Mapper
      def admin_resources(*resources, &block)
        options = resources.extract_options!.dup

        if apply_common_behavior_for(:resource, resources, options, &block)
          return self
        end

        with_scope_level(:resource) do
          options = apply_action_options options
          resource_scope(Resource.new(resources.pop, api_only?, @scope[:shallow], options)) do
            yield if block_given?

            concerns(options[:concerns]) if options[:concerns]

            collection do
              get :index if parent_resource.actions.include?(:index)
              post :create
              get :autocomplete if parent_resource.actions.include?(:autocomplete)
              patch :sort
            end if parent_resource.actions.include?(:create)

            new do
              get :new
              get :form
            end if parent_resource.actions.include?(:new)

            member do
              get :form
            end if parent_resource.actions.include?(:show)

            Model::Graph.instance.add_pair(@scope[:module], @scope[:controller])

            set_member_mappings_for_resource
          end
        end

        self
      end
    end
  end
end
