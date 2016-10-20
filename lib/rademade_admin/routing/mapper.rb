# -*- encoding : utf-8 -*-
# frozen_string_literal: true
# author: Vadim Shaveiko <@vshaveyko>
module RademadeAdmin
  module Routing
    module Mapper
      def admin_resources(*resources, &block)
        options = resources.extract_options!.dup

        if apply_common_behavior_for(:admin_resources, resources, options, &block)
          return self
        end

        with_scope_level(:resources) do
          options = apply_action_options options
          resource_scope(Resource.new(resources.pop, api_only?, @scope[:shallow], options)) do
            yield if block_given?

            concerns(options[:concerns]) if options[:concerns]

            collection do
              get :index if parent_resource.actions.include?(:index)
              get :autocomplete if parent_resource.actions.include?(:autocomplete)
            end

            collection do
              post :create
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
