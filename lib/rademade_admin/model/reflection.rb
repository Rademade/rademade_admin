# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    class Reflection

      ORM_TYPE_ACTIVERECORD = 'ActiveRecord'
      ORM_TYPE_MONGOID = 'Mongoid'
      ORM_TYPE_SEQUEL = 'Sequel'

      SUPPORTED_AR_DBMS = ['Postgresql', 'Mysql']

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
        @query_adapter ||= "RademadeAdmin::Model::Adapter::Query::#{query_adapter_type}".constantize.new(@model)
      end

      def persistence_adapter
        @persistence_adapter ||= "RademadeAdmin::Model::Adapter::Persistence::#{orm_type}".constantize.new(@model)
      end

      def hideable?
        _model_ancestors.include? RademadeAdmin::Hideable.name
      end

      protected

      def _model_ancestors
        @model_ancestors ||= @model.ancestors.map(&:to_s)
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
          'Mongoid::Document' => ORM_TYPE_MONGOID,
          'Sequel::Model' => ORM_TYPE_SEQUEL
        }
      end

      def query_adapter_type
        return orm_type unless orm_type == ORM_TYPE_ACTIVERECORD
        adapter_name = ::ActiveRecord::Base.connection_config[:adapter].downcase
        dbms_name = SUPPORTED_AR_DBMS.find { |dbms_name| adapter_name.include?(dbms_name.downcase) }
        raise 'Active record adapter not supported' unless dbms_name
        dbms_name
      end
    end
  end
end