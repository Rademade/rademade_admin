module RademadeAdmin
  module Routing
    module Mapper

      def admin_resources(*resources, &block)

        options = resources.extract_options!.dup
        options[:shallow] = true

        resources.each do |resource|
          resource_scope(:resources, Resource.new(resource, options)) do
            yield if block_given?

            parent_resource_actions = @scope[:scope_level_resource].actions

            collection do
              get :autocomplete
              patch :re_sort
            end

            new do
              get :new
              get :form
            end if parent_resource_actions.include? :new

            member do
              get :form if parent_resource_actions.include? :edit
              patch :unlink_relation if parent_resource_actions.include? :update
              put :link_relation if parent_resource_actions.include? :update
            end

            Model::Graph.instance.add_pair(@scope[:controller], self.shallow?)

          end
        end
        resources(*resources, options)

        self
      end
    end
  end
end
