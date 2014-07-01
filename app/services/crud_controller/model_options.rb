module RademadeAdmin
  module CrudController
    module ModelOptions

      attr_accessor :model_name, :item_name

      def model_name
        @model_name ||= controller_name.classify #rm_todo remove admin suffix then custom classify. RademadeAdmin::User::Options => User::Options
      end

      def item_name
        @item_name ||= model_name
      end

      def model_class
        @model_class ||= RademadeAdmin::LoaderService.const_get(model_name)
      end

      def model_reflection
        @model_reflection ||= Model::Graph.instance.model_reflection(model_class)
      end

    end
  end
end