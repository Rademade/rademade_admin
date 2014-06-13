module RademadeAdmin
  module Routing
    module Mapper

      def admin_resources(*resources, &block)

        options = resources.extract_options!.dup
        options[:shallow] = true

        #todo take controller from resources
        #todo set info with resources (parent resource, children, etc)
        resources (*resources, options) do
          yield if block_given?

          collection do
            get  :index
            get  :autocomplete
            post :create
            patch :re_sort
          end

          new do
            get :new
            get :form
          end

          member do
            get :form
            patch :unlink_relation
            put :link_relation
          end
        end

        # save connection betwen model and its controller
        resources.each { |resource| ::ModelGraph.instance.add_pair(resource, options[:controller], self.shallow?) }

        self
      end
    end
  end
end
