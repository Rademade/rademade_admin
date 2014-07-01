#todo move to routing dir
module RademadeAdmin
  module Model
    class Reflection
      include Uploader
      include Data

      attr_reader :model, :controller

      def initialize(model, controller, controller_name, inner)
        @model, @controller, @controller_name, @inner = model, controller, controller_name, inner
      end

      def parent_menu_item
        @controller_name.camelize.constantize.instance_variable_get('@parent_item')
      end

      def nested?
        @inner
      end

      # @doc
      # Admin::User => :users
      # RademadeAdmin::User::Adapter => :adapters
      def model_related_name
        @model.to_s.demodulize.pluralize.downcase.to_sym
      end

    end

    #Searcher.new(model_reflection).find params
  end
end