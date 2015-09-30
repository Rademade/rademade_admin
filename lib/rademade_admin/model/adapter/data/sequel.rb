# -*- encoding : utf-8 -*-
module RademadeAdmin
  module Model
    module Adapter
      class Data
        class Sequel < RademadeAdmin::Model::Adapter::Data

          protected

          def has_many_relations
            [:one_to_many, :many_to_many]
          end

          def has_one_relations
            [:many_to_one]
          end

          def _map_fields
            fields = {}
            @model.db_schema.each do |name, field_data|
              binding.pry
              fields[name] = RademadeAdmin::Model::Info::Field.new({
                :name => name,
                :primary => field_data[:primary_key],
                :getter => name,
                :setter => :"#{name}=",
                :is_string => field_data[:type] == :string,
                :is_date_time => field_data[:type] == :datetime,
                :is_boolean => field_data[:type] == :boolean,
                :localizable => false,
                :relation_name => name[/(.+)_id$/, 1]
              })
            end
            fields
          end

          def _map_relations
            relations = {}
            @model.association_reflections.each do |name, relation_info|
              type = relation_info.type
              to_class = RademadeAdmin::LoaderService.const_get(relation_info.class_name) rescue nil
              relations[name] = ::RademadeAdmin::Model::Info::Relation.new({
                :name => name,
                :from => @model,
                :to => to_class,
                :getter => name,
                :setter => :"#{name}=",
                :type => type,
                :many => type == :one_to_many,
                :has_many => has_many_relations.include?(type),
                :sortable => false,
                :sortable_field => nil,
                :foreign_key => relation_info.key
              })
            end
            relations
          end

        end
      end
    end
  end
end