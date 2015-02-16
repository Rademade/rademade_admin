# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Reflection

      ORM_TYPE_ACTIVERECORD = 'ActiveRecord'
      ORM_TYPE_MONGOID = 'Mongoid'

      attr_reader :model, :controller, :module_name

      def initialize(model, controller, module_name)
        @model, @controller, @module_name = model, controller, module_name
      end

      # Load data adapter for current model
      #
      # @return [RademadeAdmin::Model::Adapter::Data]
      def data_adapter
        @data_adapter ||= "RademadeAdmin::Model::Adapter::Data::#{orm_type}".constantize.new(@model)
      end

      # Load query adapter for current model
      #
      # @return [RademadeAdmin::Model::Adapter::Query]
      def query_adapter
        @query_adapter ||= "RademadeAdmin::Model::Adapter::Query::#{orm_type}".constantize.new(@model)
      end

      def hideable?
        _model_ancestors.include? RademadeAdmin::Hideable.name
      end

      protected

      def _model_ancestors
        @model_ancestors = @model.ancestors.map(&:to_s)
      end

      def orm_type
        return @orm_type unless @orm_type.nil?
        orm_list.each do |orm_class, orm_type|
          @orm_type = orm_type if _model_ancestors.include? orm_class
        end
        @orm_type
      end

      def orm_list
        @orm_list ||= {
          'ActiveRecord::Base' => ORM_TYPE_ACTIVERECORD,
          'Mongoid::Document' => ORM_TYPE_MONGOID
        }
      end

    end
  end
end
