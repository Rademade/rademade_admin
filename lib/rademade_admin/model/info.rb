# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Info

      include RademadeAdmin::Model::Info::Relations
      include RademadeAdmin::Model::Info::Fields

      UNSAVED_FIELDS = [:id, :_id, :created_at, :deleted_at, :position] # todo

      attr_reader :model_reflection

      def initialize(model_reflection, model_configuration)
        @model_reflection = model_reflection
        @model_configuration = model_configuration
        super
      end

      def uploaders
        @model_reflection.uploaders
      end

      def uploader_fields
        @model_reflection.uploader_fields
      end


      def method_missing(name, *arguments)
        if arguments.empty? and @model_configuration.respond_to? name
          @model_configuration.send(name)
        else
          @model_reflection.send(name, *arguments)
        end
      end


    end
  end
end
